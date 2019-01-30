-- Create view for combined objects' data access 
CREATE VIEW fias_view AS 
    ( 
        SELECT 
            o1.aoguid AS id,
            o1.code AS code,
            concat_ws(' '::text, o1.offname, o1.shortname) AS title,
            o1.aolevel AS level,
            o1.postalcode AS postal,
            o1.code AS kladr,
            o1.okato,
            o1.parentguid AS parent_id,
            o3.code AS parent_code,
            NULLIF(concat_ws(' '::text, o3.offname, o3.shortname), ''::text) AS parent_title,
            count(o2.aoguid) AS count_children,
            ( 
                SELECT 
                    string_agg(rec.address, ', '::text) AS full_title
                FROM 
                    ( 
                        WITH RECURSIVE my_tree AS (
                            SELECT addrobj.aoguid AS child,
                                addrobj.parentguid AS parent,
                                concat_ws(' '::text, addrobj.offname, addrobj.shortname) AS address,
                                0 AS level
                            FROM addrobj
                            WHERE (addrobj.aoguid = o1.aoguid)
                            UNION
                            SELECT addrobj.aoguid AS child,
                                addrobj.parentguid AS parent,
                                concat_ws(' '::text, addrobj.offname, addrobj.shortname) AS address,
                                (t.level + 1)
                            FROM (my_tree t
                                JOIN addrobj ON ((t.parent = addrobj.aoguid)))
                            )
                        SELECT my_tree.address,
                            my_tree.level
                        FROM my_tree
                        ORDER BY my_tree.level DESC
                    ) rec
                GROUP BY true::boolean
                LIMIT 1
            ) AS full_title
        FROM 
            addrobj o1 
            LEFT JOIN addrobj o3 ON ((o3.aoguid = o1.parentguid))
            LEFT JOIN 
            ( 
                SELECT 
                    addrobj.aoguid,
                    addrobj.parentguid
                FROM addrobj
                UNION ALL
                SELECT 
                    houses.houseguid AS aoguid,
                    houses.aoguid AS parentguid
                FROM houses
            ) o2 ON ((o2.parentguid = o1.aoguid))
        GROUP BY o1.aoguid, o1.okato, o1.offname, o1.shortname, o1.parentguid, o3.code, o3.offname, o3.shortname, o1.postalcode, o1.code
        ORDER BY o1.offname
    )
    UNION ALL
    ( 
        SELECT 
            o1.houseguid AS id,
            (o1.houseguid)::text AS code,
            concat_ws(' '::text, 'дом', o1.housenum, NULLIF(concat('корп ', o1.buildnum), 'корп '::text), NULLIF(concat('стр ', o1.strucnum), 'стр '::text)) AS title,
            777 AS level,
            o1.postalcode AS postal,
            o3.code AS kladr,
            o1.okato,
            o1.aoguid AS parent_id,
            o3.code AS parent_code,
            NULLIF(concat_ws(' '::text, o3.offname, o3.shortname), ''::text) AS parent_title,
            0 AS count_children,
            ( 
                SELECT 
                    string_agg(rec.address, ', '::text) AS full_title
                FROM 
                    ( 
                        WITH RECURSIVE my_tree AS 
                        (
                                SELECT 
                                    houses.houseguid AS child,
                                    houses.aoguid AS parent,
                                    concat_ws(' '::text, 'дом', o1.housenum, NULLIF(concat('корп ', o1.buildnum), 'корп '::text), NULLIF(concat('стр ', o1.strucnum), 'стр '::text)) AS address,
                                    0 AS level
                                FROM 
                                    houses
                                WHERE (houses.houseguid = o1.houseguid)
                                UNION
                                SELECT 
                                    addrobj.aoguid AS child,
                                    addrobj.parentguid AS parent,
                                    concat_ws(' '::text, addrobj.offname, addrobj.shortname) AS address,
                                    (t.level + 1)
                                FROM (
                                    my_tree t
                                    LEFT JOIN addrobj ON ((t.parent = addrobj.aoguid))
                                )
                        )
                        SELECT my_tree.address,
                            my_tree.level
                        FROM my_tree
                        ORDER BY my_tree.level DESC
                    ) rec
                    GROUP BY true::boolean
                    LIMIT 1
            ) AS full_title
        FROM 
        (
            houses o1
            LEFT JOIN addrobj o3 ON ((o3.aoguid = o1.aoguid))
        )
        GROUP BY o1.houseguid, o1.okato, o1.housenum, o1.strucnum, o1.aoguid, o3.offname, o3.shortname, o1.postalcode, o3.code, o1.buildnum
        ORDER BY (NULLIF(regexp_replace((o1.housenum)::text, '[^0-9]'::text, ''::text, 'g'::text), ''::text))::bigint
    );

-- Check the view is created For the first level
-- SELECT
-- 	*
-- FROM
-- 	fias_view
-- WHERE
-- 	parent_id IS NULL


-- Create MATERIALIZED view for faster access to the view's DATA
CREATE MATERIALIZED VIEW fias_mview AS SELECT * FROM fias_view;

-- Create btree indexes for mview
CREATE INDEX fias_mview_id_idx ON fias_mview USING btree (id);
CREATE INDEX fias_mview_parent_id_idx ON fias_mview USING btree (parent_id);
CREATE INDEX fias_mview_search_idx ON fias_mview USING btree (title, okato, postal, kladr);

-- Create gin indexes for mview
CREATE INDEX fias_mview_title_idx on fias_mview USING gin (title gin_trgm_ops);

-- Check the mview is created For the first level
-- SELECT
-- 	*
-- FROM
-- 	fias_mview
-- WHERE
-- 	parent_id IS NULL