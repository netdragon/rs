delete from score;
delete from bkzy;
delete from hdqk;
delete from hjqk;
delete from cjjd;
delete from attach_file;
delete from bmxx;
delete from user where admin=0;
update system_settings set value=0 where item='isPublic_Admission';
update system_settings set value=0 where item='isPublic_Admit';
update system_settings set value=0 where item='isPublic_Score';
update system_settings set value=0 where item='isPublic_Audit';