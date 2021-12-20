--
-- PostgreSQL database dump
--

-- Dumped from database version 11.14
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: fakulte_ekle(integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.fakulte_ekle(futbolcuidp integer, istatistikidp integer, sayip integer)
    LANGUAGE plpgsql
    AS $$ 
begin
update istatistikliste set futbolcuid=futbolcuidp,istatistikid=istatistikidp,sayi=sayip;
end $$;


ALTER PROCEDURE public.fakulte_ekle(futbolcuidp integer, istatistikidp integer, sayip integer) OWNER TO postgres;

--
-- Name: futbolcusayisiarttirma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.futbolcusayisiarttirma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN update futbolcuSayi set sayi=sayi+1;
return new;
end;
$$;


ALTER FUNCTION public.futbolcusayisiarttirma() OWNER TO postgres;

--
-- Name: futbolcusayisiazaltma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.futbolcusayisiazaltma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN update futbolcuSayi set sayi=sayi-1;
return new;
end;
$$;


ALTER FUNCTION public.futbolcusayisiazaltma() OWNER TO postgres;

--
-- Name: futbolcutoplamasist(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.futbolcutoplamasist(futbolcuidp integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
declare 

asist int;

begin 
asist := count(*) from asist where asist.futbolcuid=futbolcuidp;



return asist;
end;
$$;


ALTER FUNCTION public.futbolcutoplamasist(futbolcuidp integer) OWNER TO postgres;

--
-- Name: futbolcutoplamgol(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.futbolcutoplamgol(futbolcuidp integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
declare 

gol int;

begin 
gol := count(*) from gol where gol.golcuid=futbolcuidp;



return gol;
end;
$$;


ALTER FUNCTION public.futbolcutoplamgol(futbolcuidp integer) OWNER TO postgres;

--
-- Name: futbolcutoplamgolekatki(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.futbolcutoplamgolekatki(futbolcuidp integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
declare 
toplam int;
gol int;
asist int;
begin 
gol := count(*) from gol where gol.golcuid=futbolcuidp;
asist :=  count(*) from asist where asist.futbolcuid=futbolcuidp;

toplam:=gol+asist;
return toplam;
end;
$$;


ALTER FUNCTION public.futbolcutoplamgolekatki(futbolcuidp integer) OWNER TO postgres;

--
-- Name: futbolcutoplamkirmizikart(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.futbolcutoplamkirmizikart(futbolcuidp integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
declare 

kirmizikart int;

begin 
kirmizikart := count(*) from kart where kart.futbolcuid=futbolcuidp and kart.tur=1;



return kirmizikart;
end;
$$;


ALTER FUNCTION public.futbolcutoplamkirmizikart(futbolcuidp integer) OWNER TO postgres;

--
-- Name: futbolcutoplamsarikart(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.futbolcutoplamsarikart(futbolcuidp integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
declare 

sarikart int;

begin 
sarikart := count(*) from kart where kart.futbolcuid=futbolcuidp and kart.tur=2;



return sarikart;
end;
$$;


ALTER FUNCTION public.futbolcutoplamsarikart(futbolcuidp integer) OWNER TO postgres;

--
-- Name: hakemsayisiarttirma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hakemsayisiarttirma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
begin update hakemsayi set sayi=sayi+1;
return new; 
end;
$$;


ALTER FUNCTION public.hakemsayisiarttirma() OWNER TO postgres;

--
-- Name: hakemsayisiazaltma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hakemsayisiazaltma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
begin update hakemsayi set sayi=sayi-1;
return new; 
end;
$$;


ALTER FUNCTION public.hakemsayisiazaltma() OWNER TO postgres;

--
-- Name: takimsayisiarttirma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.takimsayisiarttirma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN update takimsayi set sayi=sayi+1;
return new;
end;
$$;


ALTER FUNCTION public.takimsayisiarttirma() OWNER TO postgres;

--
-- Name: takimsayisiazaltma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.takimsayisiazaltma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN update takimsayi set sayi=sayi-1;
return new;
end;
$$;


ALTER FUNCTION public.takimsayisiazaltma() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: asist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asist (
    id integer NOT NULL,
    futbolcuid integer,
    macid integer
);


ALTER TABLE public.asist OWNER TO postgres;

--
-- Name: baskan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.baskan (
    id integer NOT NULL,
    ad character varying NOT NULL,
    dyeri integer NOT NULL,
    dtarihi date NOT NULL,
    takimid integer
);


ALTER TABLE public.baskan OWNER TO postgres;

--
-- Name: futbolcu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.futbolcu (
    id integer NOT NULL,
    ad character varying NOT NULL,
    dyeri integer NOT NULL,
    dtarihi date,
    takimid integer
);


ALTER TABLE public.futbolcu OWNER TO postgres;

--
-- Name: futbolcusayi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.futbolcusayi (
    sayi integer NOT NULL
);


ALTER TABLE public.futbolcusayi OWNER TO postgres;

--
-- Name: gol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gol (
    id integer NOT NULL,
    golcuid integer,
    macid integer
);


ALTER TABLE public.gol OWNER TO postgres;

--
-- Name: hakem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hakem (
    id integer NOT NULL,
    ad character varying NOT NULL,
    dyeri integer,
    dtarihi date NOT NULL,
    klasman integer NOT NULL
);


ALTER TABLE public.hakem OWNER TO postgres;

--
-- Name: hakemklasman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hakemklasman (
    id integer NOT NULL,
    ad character varying NOT NULL
);


ALTER TABLE public.hakemklasman OWNER TO postgres;

--
-- Name: hakemsayi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hakemsayi (
    sayi integer NOT NULL
);


ALTER TABLE public.hakemsayi OWNER TO postgres;

--
-- Name: istatistik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.istatistik (
    id integer NOT NULL,
    ad character varying NOT NULL
);


ALTER TABLE public.istatistik OWNER TO postgres;

--
-- Name: istatistikliste; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.istatistikliste (
    futbolcuid integer NOT NULL,
    istatistikid integer NOT NULL,
    sayi integer NOT NULL
);


ALTER TABLE public.istatistikliste OWNER TO postgres;

--
-- Name: kart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kart (
    id integer NOT NULL,
    tur integer NOT NULL,
    hakemid integer,
    futbolcuid integer,
    macid integer
);


ALTER TABLE public.kart OWNER TO postgres;

--
-- Name: kartturu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kartturu (
    id integer NOT NULL,
    ad character varying NOT NULL
);


ALTER TABLE public.kartturu OWNER TO postgres;

--
-- Name: kazanilankupa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kazanilankupa (
    kupaid integer NOT NULL,
    kazanantakimid integer,
    tarih date NOT NULL,
    kupaturu integer NOT NULL
);


ALTER TABLE public.kazanilankupa OWNER TO postgres;

--
-- Name: kupa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kupa (
    id integer NOT NULL,
    ad character varying NOT NULL
);


ALTER TABLE public.kupa OWNER TO postgres;

--
-- Name: ligyonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ligyonetici (
    id integer NOT NULL,
    ad character varying NOT NULL,
    dyeri integer,
    dtarihi date NOT NULL
);


ALTER TABLE public.ligyonetici OWNER TO postgres;

--
-- Name: mac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mac (
    id integer NOT NULL,
    sonuc integer,
    estid integer,
    dtid integer,
    hid integer,
    stadyumid integer,
    tarih date NOT NULL
);


ALTER TABLE public.mac OWNER TO postgres;

--
-- Name: rekorsahibifutbolcu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rekorsahibifutbolcu (
    futbolcuid integer,
    rekorid integer NOT NULL
);


ALTER TABLE public.rekorsahibifutbolcu OWNER TO postgres;

--
-- Name: rekorturufutbolcu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rekorturufutbolcu (
    id integer NOT NULL,
    ad character varying
);


ALTER TABLE public.rekorturufutbolcu OWNER TO postgres;

--
-- Name: sehir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sehir (
    id integer NOT NULL,
    isim character varying NOT NULL
);


ALTER TABLE public.sehir OWNER TO postgres;

--
-- Name: stadyum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stadyum (
    id integer NOT NULL,
    ad character varying NOT NULL,
    sehirid integer NOT NULL,
    takimid integer,
    yapimyili date NOT NULL
);


ALTER TABLE public.stadyum OWNER TO postgres;

--
-- Name: takim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.takim (
    id integer NOT NULL,
    ad character varying NOT NULL,
    ktarihi date NOT NULL,
    baskanid integer
);


ALTER TABLE public.takim OWNER TO postgres;

--
-- Name: takimsayi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.takimsayi (
    sayi integer NOT NULL
);


ALTER TABLE public.takimsayi OWNER TO postgres;

--
-- Name: teknikdirektor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teknikdirektor (
    id integer NOT NULL,
    ad character varying NOT NULL,
    dyeri integer NOT NULL,
    dtarihi date NOT NULL,
    takimid integer
);


ALTER TABLE public.teknikdirektor OWNER TO postgres;

--
-- Data for Name: asist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.asist VALUES
	(1, 1, 1),
	(2, 1, 1);


--
-- Data for Name: baskan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.baskan VALUES
	(0, 'bos', 0, '2021-12-18', NULL),
	(1, 'Burak Elmas', 34, '2021-12-19', 1),
	(2, 'Ali Koç', 34, '2021-12-19', 2);


--
-- Data for Name: futbolcu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.futbolcu VALUES
	(1, 'Metin Oktay', 34, '2021-12-19', 1),
	(2, 'Rıdvan Dilmen', 34, '2021-12-19', 2);


--
-- Data for Name: futbolcusayi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.futbolcusayi VALUES
	(2);


--
-- Data for Name: gol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gol VALUES
	(1, 1, 1),
	(2, 1, 1),
	(3, 1, 1),
	(4, 2, 1);


--
-- Data for Name: hakem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hakem VALUES
	(1, 'Erman Toroğlu', 1, '2021-12-19', 1),
	(2, 'Anonscu Mutlu Çelik', 34, '2021-12-19', 1);


--
-- Data for Name: hakemklasman; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hakemklasman VALUES
	(1, 'A Klasman'),
	(2, 'B Klasman'),
	(3, 'C Klasman');


--
-- Data for Name: hakemsayi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hakemsayi VALUES
	(2);


--
-- Data for Name: istatistik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.istatistik VALUES
	(1, 'Toplam Gole Katkı'),
	(2, 'Toplam Gol Sayısı'),
	(3, 'Toplam Asist Sayısı'),
	(4, 'Toplam Kırmızı Kart Sayısı'),
	(5, 'Toplam Sarı Kart Sayısı');


--
-- Data for Name: istatistikliste; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.istatistikliste VALUES
	(1, 1, 1);


--
-- Data for Name: kart; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kart VALUES
	(1, 2, 2, 1, 2),
	(2, 1, 1, 2, 1),
	(3, 1, 1, 1, 4);


--
-- Data for Name: kartturu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kartturu VALUES
	(1, 'Kırmızı'),
	(2, 'Sarı');


--
-- Data for Name: kazanilankupa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kazanilankupa VALUES
	(1, 1, '2021-12-19', 1),
	(3, 1, '2021-12-19', 3),
	(2, 2, '2021-12-19', 3);


--
-- Data for Name: kupa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kupa VALUES
	(1, 'Türkiye Süper Ligi Kupası'),
	(2, 'Türkiye Ziraat Kupası'),
	(3, 'Türkiye Süper Kupa');


--
-- Data for Name: ligyonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ligyonetici VALUES
	(1, 'Tüpçü Fikret', 34, '2021-12-19');


--
-- Data for Name: mac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mac VALUES
	(1, 2, 1, 2, 1, 1, '2021-12-19'),
	(2, 2, 2, 1, 1, 2, '2021-12-19'),
	(3, 2, 2, 1, 1, 2, '2021-12-19'),
	(4, 2, 2, 1, 1, 2, '2021-12-19'),
	(5, 2, 2, 1, 1, 2, '2021-12-19');


--
-- Data for Name: rekorsahibifutbolcu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rekorsahibifutbolcu VALUES
	(1, 1),
	(1, 2);


--
-- Data for Name: rekorturufutbolcu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rekorturufutbolcu VALUES
	(1, 'gol kralı'),
	(2, 'asist kralı');


--
-- Data for Name: sehir; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sehir VALUES
	(0, 'boş'),
	(1, 'adana'),
	(34, 'İstanbul'),
	(6, 'ankara'),
	(28, 'giresun');


--
-- Data for Name: stadyum; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stadyum VALUES
	(0, 'boş', 0, NULL, '2021-12-18'),
	(1, 'Ali Sami Yen', 34, 1, '2021-12-19'),
	(2, 'Saraçoğlu', 34, 2, '2021-12-19');


--
-- Data for Name: takim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.takim VALUES
	(0, 'boş', '2021-12-18', NULL),
	(2, 'Fenerbahçe', '2021-12-19', 2),
	(1, 'Galatasaray', '2021-12-19', 1);


--
-- Data for Name: takimsayi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.takimsayi VALUES
	(2);


--
-- Data for Name: teknikdirektor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.teknikdirektor VALUES
	(1, 'Fatih Terim', 1, '2021-12-19', 1),
	(2, 'Zico', 1, '2021-12-19', 2);


--
-- Name: asist asist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asist
    ADD CONSTRAINT asist_pkey PRIMARY KEY (id);


--
-- Name: baskan baskan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baskan
    ADD CONSTRAINT baskan_pkey PRIMARY KEY (id);


--
-- Name: futbolcu futbolcu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.futbolcu
    ADD CONSTRAINT futbolcu_pkey PRIMARY KEY (id);


--
-- Name: gol gol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol
    ADD CONSTRAINT gol_pkey PRIMARY KEY (id);


--
-- Name: hakem hakem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hakem
    ADD CONSTRAINT hakem_pkey PRIMARY KEY (id);


--
-- Name: hakemklasman hakemklasman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hakemklasman
    ADD CONSTRAINT hakemklasman_pkey PRIMARY KEY (id);


--
-- Name: istatistik istatistik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istatistik
    ADD CONSTRAINT istatistik_pkey PRIMARY KEY (id);


--
-- Name: kart kart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kart
    ADD CONSTRAINT kart_pkey PRIMARY KEY (id);


--
-- Name: kartturu kartturu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kartturu
    ADD CONSTRAINT kartturu_pkey PRIMARY KEY (id);


--
-- Name: kupa kupa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kupa
    ADD CONSTRAINT kupa_pkey PRIMARY KEY (id);


--
-- Name: ligyonetici ligYönetici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ligyonetici
    ADD CONSTRAINT "ligYönetici_pkey" PRIMARY KEY (id);


--
-- Name: mac mac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mac
    ADD CONSTRAINT mac_pkey PRIMARY KEY (id);


--
-- Name: rekorturufutbolcu rekor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekorturufutbolcu
    ADD CONSTRAINT rekor_pkey PRIMARY KEY (id);


--
-- Name: stadyum stadyum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadyum
    ADD CONSTRAINT stadyum_pkey PRIMARY KEY (id);


--
-- Name: takim takim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.takim
    ADD CONSTRAINT takim_pkey PRIMARY KEY (id);


--
-- Name: teknikdirektor teknikDirektor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teknikdirektor
    ADD CONSTRAINT "teknikDirektor_pkey" PRIMARY KEY (id);


--
-- Name: gol unique_gol_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol
    ADD CONSTRAINT unique_gol_id UNIQUE (id);


--
-- Name: istatistik unique_istatistik_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istatistik
    ADD CONSTRAINT unique_istatistik_id UNIQUE (id);


--
-- Name: kart unique_kart_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kart
    ADD CONSTRAINT unique_kart_id UNIQUE (id);


--
-- Name: kartturu unique_kartturu_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kartturu
    ADD CONSTRAINT unique_kartturu_id UNIQUE (id);


--
-- Name: kazanilankupa unique_kazanilankupa_kupaid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kazanilankupa
    ADD CONSTRAINT unique_kazanilankupa_kupaid UNIQUE (kupaid);


--
-- Name: kupa unique_kupa_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kupa
    ADD CONSTRAINT unique_kupa_id UNIQUE (id);


--
-- Name: ligyonetici unique_ligYönetici_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ligyonetici
    ADD CONSTRAINT "unique_ligYönetici_id" UNIQUE (id);


--
-- Name: rekorturufutbolcu unique_rekor_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekorturufutbolcu
    ADD CONSTRAINT unique_rekor_id UNIQUE (id);


--
-- Name: rekorsahibifutbolcu unique_rekorsahibifutbolcu_rekorid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekorsahibifutbolcu
    ADD CONSTRAINT unique_rekorsahibifutbolcu_rekorid UNIQUE (rekorid);


--
-- Name: sehir unique_sehir_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT unique_sehir_id PRIMARY KEY (id);


--
-- Name: stadyum unique_stadyum_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadyum
    ADD CONSTRAINT unique_stadyum_id UNIQUE (id);


--
-- Name: futbolcu futbolcusayisiarttirmatrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER futbolcusayisiarttirmatrig AFTER INSERT ON public.futbolcu FOR EACH ROW EXECUTE PROCEDURE public.futbolcusayisiarttirma();


--
-- Name: futbolcu futbolcusayisiazaltmatrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER futbolcusayisiazaltmatrig AFTER DELETE ON public.futbolcu FOR EACH ROW EXECUTE PROCEDURE public.futbolcusayisiazaltma();


--
-- Name: hakem hakemsayisiarttirmatrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER hakemsayisiarttirmatrigger AFTER INSERT ON public.hakem FOR EACH ROW EXECUTE PROCEDURE public.hakemsayisiarttirma();


--
-- Name: hakem hakemsayisiazaltmatrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER hakemsayisiazaltmatrigger AFTER DELETE ON public.hakem FOR EACH ROW EXECUTE PROCEDURE public.hakemsayisiazaltma();


--
-- Name: takim takimsayisiarttirmatrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER takimsayisiarttirmatrig AFTER INSERT ON public.takim FOR EACH ROW EXECUTE PROCEDURE public.takimsayisiarttirma();


--
-- Name: takim takimsayisiazaltmatrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER takimsayisiazaltmatrig AFTER DELETE ON public.takim FOR EACH ROW EXECUTE PROCEDURE public.takimsayisiazaltma();


--
-- Name: takim baskanTakimBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.takim
    ADD CONSTRAINT "baskanTakimBB" FOREIGN KEY (baskanid) REFERENCES public.baskan(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: asist futbolcuAsistBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asist
    ADD CONSTRAINT "futbolcuAsistBB" FOREIGN KEY (futbolcuid) REFERENCES public.futbolcu(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gol futbolcuGolBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol
    ADD CONSTRAINT "futbolcuGolBB" FOREIGN KEY (golcuid) REFERENCES public.futbolcu(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hakem hakemklasmanhakemBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hakem
    ADD CONSTRAINT "hakemklasmanhakemBB" FOREIGN KEY (klasman) REFERENCES public.hakemklasman(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: istatistikliste istatistiklistefutbolcubb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istatistikliste
    ADD CONSTRAINT istatistiklistefutbolcubb FOREIGN KEY (futbolcuid) REFERENCES public.futbolcu(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: istatistikliste istatistiklisteistatistik; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istatistikliste
    ADD CONSTRAINT istatistiklisteistatistik FOREIGN KEY (istatistikid) REFERENCES public.istatistik(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kart kartFutbolcuBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kart
    ADD CONSTRAINT "kartFutbolcuBB" FOREIGN KEY (futbolcuid) REFERENCES public.futbolcu(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kart kartHakemBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kart
    ADD CONSTRAINT "kartHakemBB" FOREIGN KEY (hakemid) REFERENCES public.hakem(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kart kartkartturu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kart
    ADD CONSTRAINT kartkartturu FOREIGN KEY (tur) REFERENCES public.kartturu(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kazanilankupa kupaKazanilanKupaBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kazanilankupa
    ADD CONSTRAINT "kupaKazanilanKupaBB" FOREIGN KEY (kupaid) REFERENCES public.kupa(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: asist macAsistBC; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asist
    ADD CONSTRAINT "macAsistBC" FOREIGN KEY (macid) REFERENCES public.mac(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mac macDeplasmanBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mac
    ADD CONSTRAINT "macDeplasmanBB" FOREIGN KEY (dtid) REFERENCES public.takim(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mac macEvSahibiBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mac
    ADD CONSTRAINT "macEvSahibiBB" FOREIGN KEY (estid) REFERENCES public.takim(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gol macGolBC; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol
    ADD CONSTRAINT "macGolBC" FOREIGN KEY (macid) REFERENCES public.mac(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mac macHakemBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mac
    ADD CONSTRAINT "macHakemBB" FOREIGN KEY (hid) REFERENCES public.hakem(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kart macKartBC; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kart
    ADD CONSTRAINT "macKartBC" FOREIGN KEY (macid) REFERENCES public.mac(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mac macStadyumBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mac
    ADD CONSTRAINT "macStadyumBB" FOREIGN KEY (stadyumid) REFERENCES public.stadyum(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rekorsahibifutbolcu rekorsahibifutbolcufutbolcubb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekorsahibifutbolcu
    ADD CONSTRAINT rekorsahibifutbolcufutbolcubb FOREIGN KEY (futbolcuid) REFERENCES public.futbolcu(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rekorsahibifutbolcu rekorturufutbolcurekorsahibifutbolcu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekorsahibifutbolcu
    ADD CONSTRAINT rekorturufutbolcurekorsahibifutbolcu FOREIGN KEY (rekorid) REFERENCES public.rekorturufutbolcu(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: futbolcu sehirFutbolcuBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.futbolcu
    ADD CONSTRAINT "sehirFutbolcuBB" FOREIGN KEY (dyeri) REFERENCES public.sehir(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hakem sehirHakemBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hakem
    ADD CONSTRAINT "sehirHakemBB" FOREIGN KEY (dyeri) REFERENCES public.sehir(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ligyonetici sehirLigYoneticiBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ligyonetici
    ADD CONSTRAINT "sehirLigYoneticiBB" FOREIGN KEY (dyeri) REFERENCES public.sehir(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stadyum sehirStadyumBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadyum
    ADD CONSTRAINT "sehirStadyumBB" FOREIGN KEY (sehirid) REFERENCES public.sehir(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: teknikdirektor sehirTeknikDirektorBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teknikdirektor
    ADD CONSTRAINT "sehirTeknikDirektorBB" FOREIGN KEY (dyeri) REFERENCES public.sehir(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: futbolcu takimFutbolcuBC; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.futbolcu
    ADD CONSTRAINT "takimFutbolcuBC" FOREIGN KEY (takimid) REFERENCES public.takim(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kazanilankupa takimKazanilanKupaBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kazanilankupa
    ADD CONSTRAINT "takimKazanilanKupaBB" FOREIGN KEY (kazanantakimid) REFERENCES public.takim(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stadyum takimStadyumBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadyum
    ADD CONSTRAINT "takimStadyumBB" FOREIGN KEY (takimid) REFERENCES public.takim(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: teknikdirektor takimTeknikDirektorBB; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teknikdirektor
    ADD CONSTRAINT "takimTeknikDirektorBB" FOREIGN KEY (takimid) REFERENCES public.takim(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

