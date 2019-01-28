-- extension to implement trigrams;
CREATE EXTENSION pg_trgm;

-- drop irrelevant data from ADDROBJ
DELETE FROM addrobj WHERE livestatus != 1 AND currstatus != 0;
-- drop irrelevant data from HOUSES
DELETE FROM houses WHERE DATE_PART('second', enddate::timestamp - CURRENT_TIMESTAMP) < 0;