/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2013-11-16 14:28:11                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_KOSZTY N_JEST OBCI_ZADANIE') then
    alter table "Koszty niekadrowe"
       delete foreign key "FK_KOSZTY N_JEST OBCI_ZADANIE"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PODDZIAL_POSIADA_DZIAL') then
    alter table Poddzial
       delete foreign key FK_PODDZIAL_POSIADA_DZIAL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PROJEKT_JEST TEAM_PRACOWNI') then
    alter table Projekt
       delete foreign key "FK_PROJEKT_JEST TEAM_PRACOWNI"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PROJEKT_ZAWIERA_PROJEKT') then
    alter table Projekt
       delete foreign key FK_PROJEKT_ZAWIERA_PROJEKT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_RELATION_RELATIONS_PRACOWNI') then
    alter table Relationship_1
       delete foreign key FK_RELATION_RELATIONS_PRACOWNI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_RELATION_RELATIONS_ZADANIE') then
    alter table Relationship_1
       delete foreign key FK_RELATION_RELATIONS_ZADANIE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TYPY ZAD_ZAJMUJE S_PODDZIAL') then
    alter table "Typy zadan"
       delete foreign key "FK_TYPY ZAD_ZAJMUJE S_PODDZIAL"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ZADANIE_JEST CZES_PROJEKT') then
    alter table Zadanie
       delete foreign key "FK_ZADANIE_JEST CZES_PROJEKT"
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ZADANIE_NALEZY DO_PODDZIAL') then
    alter table Zadanie
       delete foreign key "FK_ZADANIE_NALEZY DO_PODDZIAL"
end if;

drop index if exists Dzial.Dzial_PK;

drop table if exists Dzial;

drop index if exists "Koszty niekadrowe"."jest obciazone_FK";

drop index if exists "Koszty niekadrowe"."Koszty niekadrowe_PK";

drop table if exists "Koszty niekadrowe";

drop index if exists Poddzial.posiada_FK;

drop index if exists Poddzial.Poddzial_PK;

drop table if exists Poddzial;

drop index if exists Pracownik.Pracownik_PK;

drop table if exists Pracownik;

drop index if exists Projekt.zawiera_FK;

drop index if exists Projekt."Jest teamleaderem_FK";

drop index if exists Projekt.Projekt_PK;

drop table if exists Projekt;

drop index if exists Relationship_1.Relationship_1_AK;

drop index if exists Relationship_1.Relationship_3_FK;

drop index if exists Relationship_1.Relationship_2_FK;

drop table if exists Relationship_1;

drop index if exists "Typy zadan"."zajmuje sie_FK";

drop index if exists "Typy zadan"."Typy zadan_PK";

drop table if exists "Typy zadan";

drop index if exists Zadanie."nalezy do poddzialu_FK";

drop index if exists Zadanie.Zadanie_PK;

drop table if exists Zadanie;

/*==============================================================*/
/* Table: Dzial                                                 */
/*==============================================================*/
create table Dzial 
(
   "ID dzialu"          integer                        not null,
   Nazwa                char(50)                       null,
   constraint PK_DZIAL primary key ("ID dzialu")
);

/*==============================================================*/
/* Index: Dzial_PK                                              */
/*==============================================================*/
create unique index Dzial_PK on Dzial (
"ID dzialu" ASC
);

/*==============================================================*/
/* Table: "Koszty niekadrowe"                                   */
/*==============================================================*/
create table "Koszty niekadrowe" 
(
   "ID kosztow"         integer                        not null,
   "ID projektu"        integer                        null,
   Nazwa                char(50)                       null,
   Koszt                integer                        null,
   constraint "PK_KOSZTY NIEKADROWE" primary key ("ID kosztow")
);

/*==============================================================*/
/* Index: "Koszty niekadrowe_PK"                                */
/*==============================================================*/
create unique index "Koszty niekadrowe_PK" on "Koszty niekadrowe" (
"ID kosztow" ASC
);

/*==============================================================*/
/* Index: "jest obciazone_FK"                                   */
/*==============================================================*/
create index "jest obciazone_FK" on "Koszty niekadrowe" (
"ID projektu" ASC
);

/*==============================================================*/
/* Table: Poddzial                                              */
/*==============================================================*/
create table Poddzial 
(
   "ID poddzialu"       char(50)                       not null,
   "ID dzialu"          integer                        null,
   Nazwa                char(50)                       null,
   constraint PK_PODDZIAL primary key ("ID poddzialu")
);

/*==============================================================*/
/* Index: Poddzial_PK                                           */
/*==============================================================*/
create unique index Poddzial_PK on Poddzial (
"ID poddzialu" ASC
);

/*==============================================================*/
/* Index: posiada_FK                                            */
/*==============================================================*/
create index posiada_FK on Poddzial (
"ID dzialu" ASC
);

/*==============================================================*/
/* Table: Pracownik                                             */
/*==============================================================*/
create table Pracownik 
(
   PESEL                char(11)                       not null,
   imie                 char(40)                       null,
   nazwisko             character(80)                  null,
   stawka               integer                        null,
   adres                char(50)                       null,
   mail                 char(50)                       null,
   constraint PK_PRACOWNIK primary key (PESEL)
);

/*==============================================================*/
/* Index: Pracownik_PK                                          */
/*==============================================================*/
create unique index Pracownik_PK on Pracownik (
PESEL ASC
);

/*==============================================================*/
/* Table: Projekt                                               */
/*==============================================================*/
create table Projekt 
(
   "ID projektu"        integer                        not null,
   "PESEL teamleadera"  char(11)                       null,
   Nazwa                char(50)                       null,
   ID_nadprojektu       integer                        null,
   constraint PK_PROJEKT primary key ("ID projektu")
);

/*==============================================================*/
/* Index: Projekt_PK                                            */
/*==============================================================*/
create unique index Projekt_PK on Projekt (
"ID projektu" ASC
);

/*==============================================================*/
/* Index: "Jest teamleaderem_FK"                                */
/*==============================================================*/
create index "Jest teamleaderem_FK" on Projekt (
"PESEL teamleadera" ASC
);

/*==============================================================*/
/* Index: zawiera_FK                                            */
/*==============================================================*/
create index zawiera_FK on Projekt (
ID_nadprojektu ASC
);

/*==============================================================*/
/* Table: Relationship_1                                        */
/*==============================================================*/
create table Relationship_1 
(
   PESEL                char(11)                       not null,
   "ID projektu"        integer                        not null,
   "Czas pracy"         integer                        null,
   constraint AK_IDENTIFIER_1_RELATION unique (PESEL, "ID projektu")
);

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on Relationship_1 (
PESEL ASC
);

/*==============================================================*/
/* Index: Relationship_3_FK                                     */
/*==============================================================*/
create index Relationship_3_FK on Relationship_1 (
"ID projektu" ASC
);

/*==============================================================*/
/* Index: Relationship_1_AK                                     */
/*==============================================================*/
create unique index Relationship_1_AK on Relationship_1 (
PESEL ASC,
"ID projektu" ASC
);

/*==============================================================*/
/* Table: "Typy zadan"                                          */
/*==============================================================*/
create table "Typy zadan" 
(
   "Typ zadania"        char(50)                       not null,
   "ID poddzialu"       char(50)                       null,
   constraint "PK_TYPY ZADAN" primary key ("Typ zadania")
);

/*==============================================================*/
/* Index: "Typy zadan_PK"                                       */
/*==============================================================*/
create unique index "Typy zadan_PK" on "Typy zadan" (
"Typ zadania" ASC
);

/*==============================================================*/
/* Index: "zajmuje sie_FK"                                      */
/*==============================================================*/
create index "zajmuje sie_FK" on "Typy zadan" (
"ID poddzialu" ASC
);

/*==============================================================*/
/* Table: Zadanie                                               */
/*==============================================================*/
create table Zadanie 
(
   "ID projektu"        integer                        not null,
   "ID poddzialu"       char(50)                       null,
   Nazwa                char(50)                       null,
   constraint PK_ZADANIE primary key ("ID projektu")
);

/*==============================================================*/
/* Index: Zadanie_PK                                            */
/*==============================================================*/
create unique index Zadanie_PK on Zadanie (
"ID projektu" ASC
);

/*==============================================================*/
/* Index: "nalezy do poddzialu_FK"                              */
/*==============================================================*/
create index "nalezy do poddzialu_FK" on Zadanie (
"ID poddzialu" ASC
);

alter table "Koszty niekadrowe"
   add constraint "FK_KOSZTY N_JEST OBCI_ZADANIE" foreign key ("ID projektu")
      references Zadanie ("ID projektu")
      on update restrict
      on delete restrict;

alter table Poddzial
   add constraint FK_PODDZIAL_POSIADA_DZIAL foreign key ("ID dzialu")
      references Dzial ("ID dzialu")
      on update restrict
      on delete restrict;

alter table Projekt
   add constraint "FK_PROJEKT_JEST TEAM_PRACOWNI" foreign key ("PESEL teamleadera")
      references Pracownik (PESEL)
      on update restrict
      on delete restrict;

alter table Projekt
   add constraint FK_PROJEKT_ZAWIERA_PROJEKT foreign key (ID_nadprojektu)
      references Projekt ("ID projektu")
      on update restrict
      on delete restrict;

alter table Relationship_1
   add constraint FK_RELATION_RELATIONS_PRACOWNI foreign key (PESEL)
      references Pracownik (PESEL)
      on update restrict
      on delete restrict;

alter table Relationship_1
   add constraint FK_RELATION_RELATIONS_ZADANIE foreign key ("ID projektu")
      references Zadanie ("ID projektu")
      on update restrict
      on delete restrict;

alter table "Typy zadan"
   add constraint "FK_TYPY ZAD_ZAJMUJE S_PODDZIAL" foreign key ("ID poddzialu")
      references Poddzial ("ID poddzialu")
      on update restrict
      on delete restrict;

alter table Zadanie
   add constraint "FK_ZADANIE_JEST CZES_PROJEKT" foreign key ("ID projektu")
      references Projekt ("ID projektu")
      on update restrict
      on delete restrict;

alter table Zadanie
   add constraint "FK_ZADANIE_NALEZY DO_PODDZIAL" foreign key ("ID poddzialu")
      references Poddzial ("ID poddzialu")
      on update restrict
      on delete restrict;

