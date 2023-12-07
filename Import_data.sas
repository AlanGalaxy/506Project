/* input and output paths: ------------------------------------------------- */
%let in_path = ~/506Project/;
%let out_path = ~/506Project/;
libname in_lib "&in_path.";
libname out_lib "&out_path.";
run;

/* Create a data set cbecs referring to existing file: -------------------- */
data cbecs;
  set in_lib.cbecs2018_final_public_20221205;
run;

/* view the contents of this file: ----------------------------------------- */
proc contents data = cbecs;
run;

/* use sql to create cbesc_data, which contains useful variables: --------------- */
proc sql;
	create table work.cbesc_data as
	select PBA, SQFT, NFLOOR, BASEMNT, ATTIC, FLCEILHT, YRCONC, RFTILT, 
	DAYLTP, WLCNS, RFCNS, SKYLT, GLSSPC, WINTYP, REFL, TINT, OWNOCC, OWNOPR, WKHRS, 
	NWKER, PUBCLIM, HDD65, CDD65, RENOV, RENRFF, RENWIN, RENLGT, RENHVC, RENPLB, RENELC, 
	MFBTU, MFHTBTU, MFCLBTU, MFVNBTU, MFLTBTU
	  from cbecs;
quit;

/* use sql to create cbecs_weight, which contains useful weights: --------------- */
proc sql;
	create table work.cbecs_weight as
	select *
	  from cbecs(keep=FINALWT FINALWT1-FINALWT151);
quit;

/* save the two tables in outlib: ----------------------------------------- */
data out_lib.cbesc_data;
    set work.cbesc_data;
run;

data out_lib.cbecs_weight;
    set work.cbecs_weight;
run;