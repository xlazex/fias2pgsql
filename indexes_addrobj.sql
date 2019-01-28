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