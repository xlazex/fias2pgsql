
--============ SOCRBASE ============--

-- cast column socrbase.level to int
BEGIN;
    alter table socrbase rename column level to level_x;
    alter table socrbase add column level int;
    update socrbase set level = level_x::int;
    alter table socrbase drop column level_x;
COMMIT;

--============ HOUSES ============--

--- update empty values for houses.terrifnsfl
UPDATE houses SET terrifnsfl = NULL WHERE terrifnsfl = '';

--- update empty values for houses.terrifnsul
UPDATE houses SET terrifnsul = NULL WHERE terrifnsul = '';

--- update empty values for houses.ifnsfl
UPDATE houses SET ifnsfl = NULL WHERE ifnsfl = '';

--- update empty values for houses.ifnsul
UPDATE houses SET ifnsul = NULL WHERE ifnsul = '';

--- update empty values for houses.normdoc
UPDATE houses SET normdoc = NULL WHERE normdoc = '';

--- update empty values for houses.okato
UPDATE houses SET okato = NULL WHERE okato = '';

--- update empty values for houses.oktmo
UPDATE houses SET oktmo = NULL WHERE oktmo = '';

--- update empty values for houses.buildnum
UPDATE houses SET buildnum = NULL WHERE buildnum = '';

--- update empty values for houses.strucnum
UPDATE houses SET strucnum = NULL WHERE strucnum = '';

--- update empty values for houses.postalcode
UPDATE houses SET postalcode = NULL WHERE postalcode = '';

-- cast column houses.aoguid to uuid
BEGIN;
    alter table houses rename column aoguid to aoguid_x;
    alter table houses add column aoguid uuid;
    update houses set aoguid = aoguid_x::uuid;
    alter table houses drop column aoguid_x;
COMMIT;

-- cast column houses.buildstatus to int
BEGIN;
    alter table houses rename column buildstatus to buildstatus_x;
    alter table houses add column buildstatus int;
    update houses set buildstatus = buildstatus_x::int;
    alter table houses drop column buildstatus_x;
COMMIT;

-- cast column houses.counter to int
BEGIN;
    alter table houses rename column counter to counter_x;
    alter table houses add column counter int;
    update houses set counter = counter_x::int;
    alter table houses drop column counter_x;
COMMIT;

-- cast column houses.divtype to int
BEGIN;
    alter table houses rename column divtype to divtype_x;
    alter table houses add column divtype int;
    update houses set divtype = divtype_x::int;
    alter table houses drop column divtype_x;
COMMIT;

-- cast column houses.houseguid to uuid
BEGIN;
    alter table houses rename column houseguid to houseguid_x;
    alter table houses add column houseguid uuid;
    update houses set houseguid = houseguid_x::uuid;
    alter table houses drop column houseguid_x;
COMMIT;

-- cast column houses.houseid to uuid
BEGIN;
    alter table houses rename column houseid to houseid_x;
    alter table houses add column houseid uuid;
    update houses set houseid = houseid_x::uuid;
    alter table houses drop column houseid_x;
COMMIT;

-- cast column houses.normdoc to uuid
BEGIN;
    alter table houses rename column normdoc to normdoc_x;
    alter table houses add column normdoc uuid;
    update houses set normdoc = normdoc_x::uuid;
    alter table houses drop column normdoc_x;
COMMIT;

-- cast column houses.statstatus to int
BEGIN;
    alter table houses rename column statstatus to statstatus_x;
    alter table houses add column statstatus int;
    update houses set statstatus = statstatus_x::int;
    alter table houses drop column statstatus_x;
COMMIT;

-- cast column houses.strstatus to int
BEGIN;
    alter table houses rename column strstatus to strstatus_x;
    alter table houses add column strstatus int;
    update houses set strstatus = strstatus_x::int;
    alter table houses drop column strstatus_x;
COMMIT;

--============ ADDROBJ ============--

--- update empty values for addrobj.nextid
UPDATE addrobj SET nextid = NULL WHERE nextid = '';

--- update empty values for addrobj.previd
UPDATE addrobj SET previd = NULL WHERE previd = '';

--- update empty values for addrobj.terrifnsfl
UPDATE addrobj SET terrifnsfl = NULL WHERE terrifnsfl = '';

--- update empty values for addrobj.terrifnsul
UPDATE addrobj SET terrifnsul = NULL WHERE terrifnsul = '';

--- update empty values for addrobj.ifnsfl
UPDATE addrobj SET ifnsfl = NULL WHERE ifnsfl = '';

--- update empty values for addrobj.ifnsul
UPDATE addrobj SET ifnsul = NULL WHERE ifnsul = '';

--- update empty values for addrobj.normdoc
UPDATE addrobj SET normdoc = NULL WHERE normdoc = '';

--- update empty values for addrobj.parentguid
UPDATE addrobj SET parentguid = NULL WHERE parentguid = '';

--- update empty values for addrobj.okato
UPDATE addrobj SET okato = NULL WHERE okato = '';

--- update empty values for addrobj.oktmo
UPDATE addrobj SET oktmo = NULL WHERE oktmo = '';

--- update empty values for addrobj.enddate
UPDATE addrobj SET enddate = NULL WHERE enddate = '';

--- update empty values for addrobj.startdate
UPDATE addrobj SET startdate = NULL WHERE startdate = '';

--- update empty values for addrobj.postalcode
UPDATE addrobj SET postalcode = NULL WHERE postalcode = '';

-- cast column addrobj.actstatus to int
BEGIN;
    alter table addrobj rename column actstatus to actstatus_x;
    alter table addrobj add column actstatus int;
    update addrobj set actstatus = actstatus_x::int;
    alter table addrobj drop column actstatus_x;
COMMIT;

-- cast column addrobj.aoguid to uuid
BEGIN;
    alter table addrobj rename column aoguid to aoguid_x;
    alter table addrobj add column aoguid uuid;
    update addrobj set aoguid = aoguid_x::uuid;
    alter table addrobj drop column aoguid_x;
COMMIT;

-- cast column addrobj.aoid to uuid
BEGIN;
    alter table addrobj rename column aoid to aoid_x;
    alter table addrobj add column aoid uuid;
    update addrobj set aoid = aoid_x::uuid;
    alter table addrobj drop column aoid_x;
COMMIT;

-- cast column addrobj.aolevel to int
BEGIN;
    alter table addrobj rename column aolevel to aolevel_x;
    alter table addrobj add column aolevel int;
    update addrobj set aolevel = aolevel_x::int;
    alter table addrobj drop column aolevel_x;
COMMIT;

-- cast column addrobj.centstatus to int
BEGIN;
    alter table addrobj rename column centstatus to centstatus_x;
    alter table addrobj add column centstatus int;
    update addrobj set centstatus = centstatus_x::int;
    alter table addrobj drop column centstatus_x;
COMMIT;

-- cast column addrobj.currstatus to int
BEGIN;
    alter table addrobj rename column currstatus to currstatus_x;
    alter table addrobj add column currstatus int;
    update addrobj set currstatus = currstatus_x::int;
    alter table addrobj drop column currstatus_x;
COMMIT;

-- cast column addrobj.livestatus to int
BEGIN;
    alter table addrobj rename column livestatus to livestatus_x;
    alter table addrobj add column livestatus int;
    update addrobj set livestatus = livestatus_x::int;
    alter table addrobj drop column livestatus_x;
COMMIT;

-- cast column addrobj.nextid to uuid
BEGIN;
    alter table addrobj rename column nextid to nextid_x;
    alter table addrobj add column nextid uuid;
    update addrobj set nextid = nextid_x::uuid;
    alter table addrobj drop column nextid_x;
COMMIT;

-- cast column addrobj.normdoc to uuid
BEGIN;
    alter table addrobj rename column normdoc to normdoc_x;
    alter table addrobj add column normdoc uuid;
    update addrobj set normdoc = normdoc_x::uuid;
    alter table addrobj drop column normdoc_x;
COMMIT;

-- cast column addrobj.operstatus to int
BEGIN;
    alter table addrobj rename column operstatus to operstatus_x;
    alter table addrobj add column operstatus int;
    update addrobj set operstatus = operstatus_x::int;
    alter table addrobj drop column operstatus_x;
COMMIT;

-- cast column addrobj.parentguid to uuid
BEGIN;
    alter table addrobj rename column parentguid to parentguid_x;
    alter table addrobj add column parentguid uuid;
    update addrobj set parentguid = parentguid_x::uuid;
    alter table addrobj drop column parentguid_x;
COMMIT;

-- cast column addrobj.previd to uuid
BEGIN;
    alter table addrobj rename column previd to previd_x;
    alter table addrobj add column previd uuid;
    update addrobj set previd = previd_x::uuid;
    alter table addrobj drop column previd_x;
COMMIT;
