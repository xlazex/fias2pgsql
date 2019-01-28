--========== SOCRBASE ==========--

-- primary key (shortname)
-- ALTER TABLE socrbase DROP CONSTRAINT socrbase_pkey;
ALTER TABLE socrbase ADD CONSTRAINT socrbase_pkey PRIMARY KEY(kod_t_st);

CREATE UNIQUE INDEX kod_t_st_idx ON socrbase USING btree (kod_t_st);
CREATE INDEX scname_level_idx ON socrbase USING btree (scname, level);