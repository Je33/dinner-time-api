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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    id bigint NOT NULL,
    title character varying DEFAULT ''::character varying NOT NULL,
    cook_time integer DEFAULT 0 NOT NULL,
    prep_time integer DEFAULT 0 NOT NULL,
    ratings numeric(5,2) DEFAULT 0.0 NOT NULL,
    cuisine character varying DEFAULT ''::character varying NOT NULL,
    category character varying DEFAULT ''::character varying NOT NULL,
    author character varying DEFAULT ''::character varying NOT NULL,
    image character varying DEFAULT ''::character varying NOT NULL,
    ingredients jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS (setweight(jsonb_to_tsvector('english'::regconfig, ingredients, '["string"]'::jsonb), 'a'::"char")) STORED
);


--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_recipes_on_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_category ON public.recipes USING btree (category);


--
-- Name: index_recipes_on_cook_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_cook_time ON public.recipes USING btree (cook_time);


--
-- Name: index_recipes_on_cuisine; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_cuisine ON public.recipes USING btree (cuisine);


--
-- Name: index_recipes_on_ratings; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_ratings ON public.recipes USING btree (ratings);


--
-- Name: index_recipes_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_searchable ON public.recipes USING gin (searchable);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20240518160530'),
('20240518152323');

