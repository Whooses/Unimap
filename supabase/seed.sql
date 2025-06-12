SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

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
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: auth0_users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."user" ("id", "username", "email", "pfp_url", "created_at", "updated_at", "is_verified", "timezone", "auth0_id") VALUES
	(1, 'amacss_admin', 'amacss_admin@utsc.ca', 'https://example.com/pfp1.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(2, 'math_user', 'math_user@utsc.ca', 'https://example.com/pfp2.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(3, 'csec_lead', 'csec_lead@utsc.ca', 'https://example.com/pfp3.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(4, 'csec_admin', 'csec_admin@utsc.ca', 'https://example.com/pfp4.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(5, 'prog_enthusiast', 'prog_enthusiast@utsc.ca', 'https://example.com/pfp5.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(6, 'techie_tim', 'techie_tim@utsc.ca', 'https://example.com/pfp6.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(7, 'math_admin', 'math_admin@utsc.ca', 'https://example.com/pfp7.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(8, 'csec_member1', 'csec_member1@utsc.ca', 'https://example.com/pfp8.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(9, 'prog_master', 'prog_master@utsc.ca', 'https://example.com/pfp9.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(10, 'career_math', 'career_math@utsc.ca', 'https://example.com/pfp10.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(11, 'women_cs', 'women_cs@utsc.ca', 'https://example.com/pfp11.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(12, 'prog_user', 'prog_user@utsc.ca', 'https://example.com/pfp12.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(13, 'math_speaker', 'math_speaker@utsc.ca', 'https://example.com/pfp13.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(14, 'golf_guru', 'golf_guru@utsc.ca', 'https://example.com/pfp14.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(15, 'ds_talker', 'ds_talker@utsc.ca', 'https://example.com/pfp15.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(16, 'math_ta', 'math_ta@utsc.ca', 'https://example.com/pfp16.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(17, 'web_starter', 'web_starter@utsc.ca', 'https://example.com/pfp17.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(18, 'fp_dev', 'fp_dev@utsc.ca', 'https://example.com/pfp18.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(19, 'prog_nightowl', 'prog_nightowl@utsc.ca', 'https://example.com/pfp19.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(20, 'amacss_speaker', 'amacss_speaker@utsc.ca', 'https://example.com/pfp20.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(21, 'csec_alumni', 'csec_alumni@utsc.ca', 'https://example.com/pfp21.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(22, 'oss_helper', 'oss_helper@utsc.ca', 'https://example.com/pfp22.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(23, 'math_mentor', 'math_mentor@utsc.ca', 'https://example.com/pfp23.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(24, 'cloud_fan', 'cloud_fan@utsc.ca', 'https://example.com/pfp24.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL),
	(25, 'prog_advanced', 'prog_advanced@utsc.ca', 'https://example.com/pfp25.jpg', '2025-05-18 01:53:06.16759+00', '2025-05-18 01:53:06.16759+00', false, NULL, NULL);


--
-- Data for Name: bug_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."event" ("id", "title", "description", "date", "location", "user_id", "image_url", "is_public", "created_at", "updated_at", "username", "departments", "categories", "clubs", "types", "owner_id", "is_in_person", "is_online") VALUES
	(53, 'Math Jeopardy!', 'Test your math skills in a Jeopardy format.', '2025-05-28 00:00:00+00', 'SW-105', 2, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-18 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'math_user', '{Mathematics}', '{"Game Night"}', '{"mathematics club"}', '{Trivia}', 2, NULL, NULL),
	(59, 'Game Jam 2025', '24-hour game dev event.', '2025-07-10 00:00:00+00', 'IC Atrium', 9, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_master', '{"Computer Science"}', '{Hackathon}', '{"programming club"}', '{Competition}', 9, NULL, NULL),
	(54, 'Cybersecurity Basics', 'Workshop on staying safe online.', '2025-06-18 00:00:00+00', 'IC Lab 3', 4, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-15 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'csec_admin', '{"Computer Science"}', '{Workshop}', '{csec}', '{Learning}', 4, NULL, NULL),
	(71, 'CSEC Alumni Mixer', 'Reconnect with CSEC alumni.', '2025-06-12 00:00:00+00', 'IC Lounge', 21, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-16 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'csec_admin', '{"Computer Science"}', '{Networking}', '{csec}', '{Social}', 21, NULL, NULL),
	(51, 'Coding Bootcamp', 'Beginner-friendly JavaScript course.', '2025-06-15 00:00:00+00', 'Online (Zoom)', 3, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-15 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'csec_lead', '{"Computer Science"}', '{Workshop}', '{csec}', '{Learning}', 3, true, NULL),
	(66, 'Discrete Math Review', 'Finals prep session for MATB24.', '2025-06-01 00:00:00+00', 'SW-112', 16, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'math_ta', '{Mathematics}', '{"Study Session"}', '{"mathematics club"}', '{Review}', 16, NULL, true),
	(58, 'Git and GitHub Basics', 'Learn version control with Git.', '2025-06-22 00:00:00+00', 'IC-410', 8, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'csec_lead', '{"Computer Science"}', '{Workshop}', '{csec}', '{Learning}', 8, true, NULL),
	(60, 'Math Careers Panel', 'Hear from alumni in math careers.', '2025-06-08 00:00:00+00', 'Science Lecture Hall', 10, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-15 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'math_user', '{Mathematics}', '{Panel}', '{"mathematics club"}', '{Networking}', 10, true, NULL),
	(74, 'Cloud Computing Basics', 'Explore AWS and cloud tech.', '2025-06-14 00:00:00+00', 'IC-401', 24, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-16 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'csec_user', '{"Computer Science"}', '{Tech}', '{csec}', '{Learning}', 24, NULL, true),
	(73, 'Math Meet & Greet', 'Social event for new math students.', '2025-06-03 00:00:00+00', 'SW-100', 23, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-15 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'math_mentor', '{Mathematics}', '{Social}', '{"mathematics club"}', '{Community}', 23, true, NULL),
	(75, 'Advanced Algorithms', 'Dive deep into dynamic programming.', '2025-06-25 00:00:00+00', 'IC-411', 25, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_advanced', '{"Computer Science"}', '{Lecture}', '{"programming club"}', '{Academic}', 25, true, true),
	(55, 'Python Practice', 'Solve coding challenges in Python.', '2025-06-05 00:00:00+00', 'IC 404', 5, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-16 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_enthusiast', '{"Computer Science"}', '{Practice}', '{"programming club"}', '{Challenge}', 5, NULL, true),
	(56, 'Intro to Linux', 'A past event teaching Linux basics.', '2025-03-15 00:00:00+00', 'SW-210', 6, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', false, '2025-03-19 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'techie_tim', '{"Computer Science"}', '{Workshop}', '{csec}', '{Learning}', 6, true, true),
	(57, 'Fun with Logic', 'Math games based on logical reasoning.', '2025-02-28 00:00:00+00', 'SW-120', 7, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-03-09 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'math_admin', '{Mathematics}', '{Games}', '{"mathematics club"}', '{Educational}', 7, NULL, true),
	(70, 'AI Ethics Talk', 'Discussing the future of AI.', '2025-07-01 00:00:00+00', 'IC Auditorium', 20, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'amacss_speaker', '{"Computer Science"}', '{Talk}', '{amacss}', '{Discussion}', 20, true, true),
	(72, 'Open Source Intro', 'How to contribute to OSS.', '2025-06-07 00:00:00+00', 'Online', 22, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_user', '{"Computer Science"}', '{Workshop}', '{"programming club"}', '{Tech}', 22, NULL, true),
	(52, 'Speed Coding Challenge', 'Code fast, win prizes!', '2025-06-01 00:00:00+00', 'IC-402', 1, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-18 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_master', '{"Computer Science"}', '{Competition}', '{"programming club"}', '{Challenge}', 1, NULL, true),
	(63, 'Math Research Talk', 'Undergraduate math research showcase.', '2025-06-02 00:00:00+00', 'SW-205', 13, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-16 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'math_user', '{Mathematics}', '{Talk}', '{"Mathematics Club"}', '{Academic}', 13, NULL, NULL),
	(49, 'Hack the Future', 'A hackathon for all skill levels.', '2025-07-20 00:00:00+00', 'IC Building, Room 402', 1, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'amacss_admin', '{"Computer Science"}', '{Hackathon}', '{amacss}', '{Competition}', 1, true, NULL),
	(62, 'Algorithm Workshop', 'Learn sorting algorithms.', '2025-06-30 00:00:00+00', 'IC-312', 12, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_user', '{"Computer Science"}', '{Workshop}', '{"programming club"}', '{Educational}', 12, true, NULL),
	(65, 'Data Science Demystified', 'Intro to data science methods.', '2025-07-05 00:00:00+00', 'IC 110', 15, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-15 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'amacss_admin', '{"Computer Science"}', '{Talk}', '{amacss}', '{Educational}', 15, NULL, true),
	(67, 'Intro to Web Dev', 'Learn HTML/CSS/JS basics.', '2025-06-11 00:00:00+00', 'IC-406', 17, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-16 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'csec_lead', '{"Computer Science"}', '{Workshop}', '{csec}', '{Learning}', 17, true, true),
	(69, 'Late Night Leetcode', 'Group problem solving session.', '2025-06-20 00:00:00+00', 'IC Lab 2', 19, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-17 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_nightowl', '{"Computer Science"}', '{Study}', '{"programming club"}', '{Practice}', 19, true, NULL),
	(68, 'Functional Programming', 'Haskell intro night.', '2025-05-30 00:00:00+00', 'Online', 18, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-13 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_enthusiast', '{"Computer Science"}', '{Workshop}', '{"programming club"}', '{Educational}', 18, NULL, true),
	(50, 'Math Puzzle Night', 'Collaborative math challenges and prizes.', '2025-06-10 00:00:00+00', 'Science Wing 115', 2, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-16 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'math_user', '{Mathematics}', '{Puzzle}', '{"mathematics club"}', '{Social}', 2, true, true),
	(61, 'Women in Tech Panel', 'Empowering women in CS.', '2025-05-25 00:00:00+00', 'Online', 11, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-13 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'amacss_admin', '{"Computer Science"}', '{Panel}', '{amacss}', '{Awareness}', 11, NULL, true),
	(64, 'Code Golf Night', 'Solve problems with the shortest code.', '2025-06-27 00:00:00+00', 'IC Lab 1', 14, 'https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg', true, '2025-05-14 01:53:10.593328+00', '2025-05-18 01:53:10.593328+00', 'prog_master', '{"Computer Science"}', '{Competition}', '{"programming club"}', '{Game}', 14, true, true);


--
-- Data for Name: event_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: school; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_school; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id") VALUES
	('event_images', 'event_images', NULL, '2025-02-04 19:35:21.764635+00', '2025-02-04 19:35:21.764635+00', true, false, NULL, NULL, NULL);


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") VALUES
	('e2462ef4-5fdf-4072-b068-a047d354268c', 'event_images', '.emptyFolderPlaceholder', NULL, '2025-02-04 20:56:39.948237+00', '2025-02-04 20:56:39.948237+00', '2025-02-04 20:56:39.948237+00', '{"eTag": "\"d41d8cd98f00b204e9800998ecf8427e\"", "size": 0, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-02-04T20:56:40.000Z", "contentLength": 0, "httpStatusCode": 200}', 'dd04bfe9-947a-4653-b56a-d1c5f10b7def', NULL, '{}'),
	('275ffb5d-f5cc-4b9a-8568-d77f0b6f408e', 'event_images', 'eventImg.png', NULL, '2025-02-04 20:56:51.679966+00', '2025-02-04 20:56:51.679966+00', '2025-02-04 20:56:51.679966+00', '{"eTag": "\"26b636d97872a76674885c58237c6075-1\"", "size": 94207, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-04T20:56:52.000Z", "contentLength": 94207, "httpStatusCode": 200}', '9c8bfed2-280b-4b6b-ae52-b5d911a3bcf8', NULL, NULL),
	('94de547d-ab1e-490e-aecd-c206fa194201', 'event_images', 'eventImg2.png', NULL, '2025-02-04 21:56:45.552795+00', '2025-02-04 21:56:45.552795+00', '2025-02-04 21:56:45.552795+00', '{"eTag": "\"c4065e9a1da57997077e8231b1a2d81d-1\"", "size": 873733, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-04T21:56:46.000Z", "contentLength": 873733, "httpStatusCode": 200}', 'fe192700-e685-4d2c-afb5-78f317b4f267', NULL, NULL),
	('2a8ccbe0-dce4-4ef8-b2d4-de924c9aed26', 'event_images', 'eventImg3.png', NULL, '2025-02-04 21:59:42.346403+00', '2025-02-04 21:59:42.346403+00', '2025-02-04 21:59:42.346403+00', '{"eTag": "\"f9a38e050879bf415faa5e979ded0a23-1\"", "size": 2211073, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-04T21:59:42.000Z", "contentLength": 2211073, "httpStatusCode": 200}', '5b775a01-99ad-4efb-be77-47e557d68847', NULL, NULL);


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- Name: Events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Events_id_seq"', 75, true);


--
-- Name: bug_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."bug_reports_id_seq"', 1, false);


--
-- Name: event_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."event_reports_id_seq"', 1, false);


--
-- Name: school_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."school_id_seq"', 1, false);


--
-- Name: user_school_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."user_school_user_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."users_id_seq"', 5, true);


--
-- PostgreSQL database dump complete
--

RESET ALL;
