--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: chirper; Type: TABLE; Schema: public; Owner: codybarber
--

CREATE TABLE chirper (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    profile_image text,
    email text
);


ALTER TABLE chirper OWNER TO codybarber;

--
-- Name: chirper_id_seq; Type: SEQUENCE; Schema: public; Owner: codybarber
--

CREATE SEQUENCE chirper_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chirper_id_seq OWNER TO codybarber;

--
-- Name: chirper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: codybarber
--

ALTER SEQUENCE chirper_id_seq OWNED BY chirper.id;


--
-- Name: chirps; Type: TABLE; Schema: public; Owner: codybarber
--

CREATE TABLE chirps (
    id integer NOT NULL,
    chirp text,
    chirper_id integer,
    date timestamp without time zone NOT NULL
);


ALTER TABLE chirps OWNER TO codybarber;

--
-- Name: chirps_id_seq; Type: SEQUENCE; Schema: public; Owner: codybarber
--

CREATE SEQUENCE chirps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chirps_id_seq OWNER TO codybarber;

--
-- Name: chirps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: codybarber
--

ALTER SEQUENCE chirps_id_seq OWNED BY chirps.id;


--
-- Name: follow; Type: TABLE; Schema: public; Owner: codybarber
--

CREATE TABLE follow (
    id integer NOT NULL,
    chirper_id integer,
    chirper_followed integer
);


ALTER TABLE follow OWNER TO codybarber;

--
-- Name: follow_id_seq; Type: SEQUENCE; Schema: public; Owner: codybarber
--

CREATE SEQUENCE follow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE follow_id_seq OWNER TO codybarber;

--
-- Name: follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: codybarber
--

ALTER SEQUENCE follow_id_seq OWNED BY follow.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY chirper ALTER COLUMN id SET DEFAULT nextval('chirper_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY chirps ALTER COLUMN id SET DEFAULT nextval('chirps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY follow ALTER COLUMN id SET DEFAULT nextval('follow_id_seq'::regclass);


--
-- Data for Name: chirper; Type: TABLE DATA; Schema: public; Owner: codybarber
--

COPY chirper (id, username, password, profile_image, email) FROM stdin;
1	cody_b	$2b$12$hseHBph1FpY4oRYMqsbYpOdxjddsgXooVjnW5lHxbV9wwdkWGQM.i	https://pbs.twimg.com/profile_images/753041237956001792/BvKG1iwF.jpg	cody@email.com
3	deedee_k	$2b$12$wJDRlajxFBWoWNVjmiirguLRxyWWJdGss5Hyok36WE1TS3bSD7AOu	https://pbs.twimg.com/profile_images/743776366739525632/shtUYhPp.jpg	deeann@email.com
9	anthony_trains	$2b$12$CQYRod7VHTyTR.1rcGWZZ.pEMUcwcIIJC2taZ/jMTMolJZ2n7mA8u	https://avatars3.githubusercontent.com/u/19190774?v=3&s=400	anthony@email.com
7	raygan_reegan	$2b$12$z7yVR8KtOeaYHBJVPBr7L.T13SAzSI/ydzz40OhwQBPV6Lv/91Zma	https://avatars0.githubusercontent.com/u/19190781?v=3&s=400	regan@email.com
2	kyle_l	$2b$12$Kpu4.80jGycpcGCJE2Vm3.wSJVFSeSCtPlJ/dCOc9hCnxFY4wXi12	https://avatars0.githubusercontent.com/u/4989933?v=3&s=400	kyle@email.com
10	dave_p	$2b$12$2NTwLOY/JtL/.kIYlwB4guAKEuWWb3CKPP6dFZK5weLrusgXSc4By	https://avatars0.githubusercontent.com/u/8472801?v=3&s=400	dave@email.com
4	carol_d	$2b$12$yd90C183pvN2wSkw4YB8L.VqCfkSLslrLD5EZZKj5u8sM1GlHaQ.K	https://avatars3.githubusercontent.com/u/19159752?v=3&s=400	carol@email.com
8	mattyb	$2b$12$anfEbo43N/E387Tj/s0n6O0dzcTaB4vqAUIozFId2A2pZKRyoXeUa	https://avatars2.githubusercontent.com/u/19143056?v=3&s=400	matt@email.com
6	tim_s	$2b$12$lFiuHAdvHeV1ntnEi5sv3u.VftdEYAkd0EDF2F65KsZQs/gJd1cBC	https://avatars3.githubusercontent.com/u/19190953?v=3&s=400	tim@email.com
5	tobes_h	$2b$12$CCwKenkk47L5ftODk7S2LegO4kCxbLunzZtO5KwAZB78f1MQO0deK	https://pbs.twimg.com/profile_images/52579241/avatar.jpg	toby@email.com
22	will	$2b$12$G2PRDqYBthOQnD5cSVHHjO7Kyc6JawswZ7DB1dBz1qll8CIG3Q9/y	\N	will@email.com
24	shanda	$2b$12$NuHJ8ZEHGete6BjWraHmp.oyWoT3fneC62gFAh/gJAei7cc6/j3di	\N	shanda@email.com
\.


--
-- Name: chirper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: codybarber
--

SELECT pg_catalog.setval('chirper_id_seq', 24, true);


--
-- Data for Name: chirps; Type: TABLE DATA; Schema: public; Owner: codybarber
--

COPY chirps (id, chirp, chirper_id, date) FROM stdin;
4	i love digitalcrafts	1	2016-07-01 00:00:00
5	@tobes_h is the best	1	2016-07-02 00:00:00
6	go dawgs	1	2016-07-15 00:00:00
7	traffic is so bad	2	2016-07-21 00:00:00
8	hello	2	2016-07-01 00:00:00
9	where is the party at?	2	2016-07-23 00:00:00
10	been in traffic for twelve hours	3	2016-07-15 00:00:00
11	curly hair, don't care	3	2016-07-11 00:00:00
12	shooooooot	4	2016-07-26 00:00:00
13	code lyfe	4	2016-07-21 00:00:00
14	yoga lyfe	4	2016-07-23 00:00:00
15	students had trouble with big O notation today	5	2016-07-21 00:00:00
16	atlanta js meetup tonight!	5	2016-07-01 00:00:00
17	i should try out for the hawks	5	2016-07-15 00:00:00
18	beautiful weather today	6	2016-07-21 00:00:00
19	do i look hammered?	7	2016-07-01 00:00:00
20	where am i? where do i live?	7	2016-07-01 00:00:00
21	twin peaks = best food in atlanta	7	2016-07-23 00:00:00
22	ionic is life	8	2016-07-15 00:00:00
23	eat better	9	2016-07-23 00:00:00
24	work harder	9	2016-07-23 00:00:00
25	so tired	9	2016-07-01 00:00:00
26	is this app secure enough?	10	2016-07-11 00:00:00
27	i miss hawaii	10	2016-07-15 00:00:00
67	test	3	2016-07-28 16:07:37
68	hello	3	2016-07-28 16:08:19
69	it's working	3	2016-07-28 16:08:26
70	It's me	1	2016-07-28 16:35:43
71	hey yall	24	2016-07-28 16:50:43
72	always be chirpin	8	2016-07-28 17:51:43
\.


--
-- Name: chirps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: codybarber
--

SELECT pg_catalog.setval('chirps_id_seq', 72, true);


--
-- Data for Name: follow; Type: TABLE DATA; Schema: public; Owner: codybarber
--

COPY follow (id, chirper_id, chirper_followed) FROM stdin;
9	2	6
20	5	6
23	6	6
31	7	6
10	2	7
17	4	7
27	7	7
33	8	7
24	6	8
32	8	8
48	10	8
25	6	9
35	9	9
44	9	9
47	10	9
18	4	10
26	6	10
40	9	10
45	10	10
1	1	1
12	3	1
21	5	1
36	9	1
6	2	2
13	3	2
22	5	2
3	1	3
11	3	3
14	3	3
16	4	3
39	9	3
2	1	4
7	2	4
15	4	4
38	9	4
8	2	5
19	5	5
30	7	5
34	8	5
37	9	5
\.


--
-- Name: follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: codybarber
--

SELECT pg_catalog.setval('follow_id_seq', 100, true);


--
-- Name: chirper_pkey; Type: CONSTRAINT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY chirper
    ADD CONSTRAINT chirper_pkey PRIMARY KEY (id);


--
-- Name: chirper_username_key; Type: CONSTRAINT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY chirper
    ADD CONSTRAINT chirper_username_key UNIQUE (username);


--
-- Name: chirps_pkey; Type: CONSTRAINT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY chirps
    ADD CONSTRAINT chirps_pkey PRIMARY KEY (id);


--
-- Name: follow_pkey; Type: CONSTRAINT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY follow
    ADD CONSTRAINT follow_pkey PRIMARY KEY (id);


--
-- Name: chirps_chirper_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY chirps
    ADD CONSTRAINT chirps_chirper_id_fkey FOREIGN KEY (chirper_id) REFERENCES chirper(id);


--
-- Name: follow_chirper_followed_fkey; Type: FK CONSTRAINT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY follow
    ADD CONSTRAINT follow_chirper_followed_fkey FOREIGN KEY (chirper_followed) REFERENCES chirper(id);


--
-- Name: follow_chirper_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: codybarber
--

ALTER TABLE ONLY follow
    ADD CONSTRAINT follow_chirper_id_fkey FOREIGN KEY (chirper_id) REFERENCES chirper(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

