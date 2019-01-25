-- extension to implement trigrams;
CREATE EXTENSION pg_trgm;


-- drop irrelevant data from ADDROBJ
DELETE FROM addrobj WHERE livestatus != 1 AND currstatus != 0;
-- drop irrelevant data from HOUSES
DELETE FROM houses WHERE DATE_PART('second', enddate::timestamp - CURRENT_TIMESTAMP) < 0;


--========== SOCRBASE ==========--

-- primary key (shortname)
-- ALTER TABLE socrbase DROP CONSTRAINT socrbase_pkey;
ALTER TABLE socrbase ADD CONSTRAINT socrbase_pkey PRIMARY KEY(kod_t_st);

CREATE UNIQUE INDEX kod_t_st_idx ON socrbase USING btree (kod_t_st);
CREATE INDEX scname_level_idx ON socrbase USING btree (scname, level);


--========== ADDROBJ ==========--


-- primary key (aoguid)
-- ALTER TABLE addrobj DROP CONSTRAINT addrobj_pkey;
ALTER TABLE addrobj ADD CONSTRAINT addrobj_pkey PRIMARY KEY(aoguid);


-- foreign key (parentguid to aoguid)
-- ALTER TABLE addrobj DROP CONSTRAINT addrobj_parentguid_fkey;
ALTER TABLE addrobj
  ADD CONSTRAINT addrobj_parentguid_fkey FOREIGN KEY (parentguid)
  REFERENCES addrobj (aoguid) MATCH SIMPLE
  ON UPDATE CASCADE ON DELETE NO ACTION;


--  create btree indexes
CREATE UNIQUE INDEX addrobj_aoguid_pk_idx ON addrobj USING btree (aoguid);
CREATE UNIQUE INDEX addrobj_aoid_idx ON addrobj USING btree (aoid);
CREATE INDEX addrobj_parentguid_idx ON addrobj USING btree (parentguid);
CREATE INDEX addrobj_currstatus_idx ON addrobj USING btree (currstatus);
CREATE INDEX addrobj_aolevel_idx ON addrobj USING btree (aolevel);
CREATE INDEX addrobj_formalname_idx ON addrobj USING btree (formalname);
CREATE INDEX addrobj_offname_idx ON addrobj USING btree (offname);
CREATE INDEX addrobj_shortname_idx ON addrobj USING btree (shortname);
CREATE INDEX addrobj_shortname_aolevel_idx ON addrobj USING btree (shortname, aolevel);
CREATE INDEX addrobj_code_idx ON addrobj USING btree (code);
CREATE INDEX addrobj_plaincode_idx ON addrobj USING btree (plaincode);
CREATE INDEX addrobj_okato_idx ON addrobj USING btree (okato);
CREATE INDEX addrobj_oktmo_idx ON addrobj USING btree (oktmo);


-- trigram indexes to speed up text searches
CREATE INDEX addrobj_formalname_trgm_idx on addrobj USING gin (formalname gin_trgm_ops);
CREATE INDEX addrobj_offname_trgm_idx on addrobj USING gin (offname gin_trgm_ops);


--========== HOUSES ==========--

-- Create temp key for duplicate rows detete
ALTER TABLE houses ADD COLUMN _id SERIAL;

-- Delete duplicate rows from table (if exists)
WITH un AS
	(
		SELECT 
			DISTINCT ON (houseguid) *
	 	FROM 
			spr.houses
	)
DELETE FROM spr.houses WHERE houses._id NOT IN (SELECT _id FROM un);

-- Drop temp column
ALTER TABLE houses DROP COLUMN _id;

-- primary key (houseguid)
-- ALTER TABLE houses DROP CONSTRAINT houses_pkey;
ALTER TABLE houses ADD CONSTRAINT houses_pkey PRIMARY KEY(houseguid);


-- foreign key (houses.aoguid to addrobj.aoguid)
-- ALTER TABLE houses DROP CONSTRAINT houses_parentguid_fkey;
ALTER TABLE houses
  ADD CONSTRAINT houses_parentguid_fkey FOREIGN KEY (aoguid)
  REFERENCES addrobj (aoguid) MATCH SIMPLE
  ON UPDATE CASCADE ON DELETE NO ACTION;


--  create btree indexes
CREATE INDEX houses_aoguid_idx ON houses USING btree (aoguid);
CREATE UNIQUE INDEX houses_houseguid_idx ON houses USING btree (houseguid);
CREATE INDEX houses_houseid_idx ON houses USING btree (houseid);
CREATE INDEX houses_housenum_idx ON houses USING btree (housenum);
CREATE INDEX houses_okato_idx ON houses USING btree (okato);
CREATE INDEX houses_oktmo_idx ON houses USING btree (oktmo);
