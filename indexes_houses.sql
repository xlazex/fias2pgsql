--========== HOUSES ==========--

-- Create temp key for duplicate rows detete
ALTER TABLE houses ADD COLUMN _id SERIAL;

-- Delete duplicate rows from table
-- [WARNING! long execution time..]
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
