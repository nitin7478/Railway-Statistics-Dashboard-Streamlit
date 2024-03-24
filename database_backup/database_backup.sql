toc.dat                                                                                             0000600 0004000 0002000 00000151726 14600074532 0014454 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP   9    "                 |            railway_dashboard    16.2    16.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    16398    railway_dashboard    DATABASE     �   CREATE DATABASE railway_dashboard WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 !   DROP DATABASE railway_dashboard;
                postgres    false                     2615    16399 	   divisions    SCHEMA        CREATE SCHEMA divisions;
    DROP SCHEMA divisions;
                postgres    false         �            1259    16479    division    TABLE       CREATE TABLE public.division (
    division_code character varying(5) NOT NULL,
    division_name character varying(30) NOT NULL,
    railway_code character varying(5) DEFAULT 'CR'::character varying NOT NULL,
    location character varying,
    contact_info character varying
);
    DROP TABLE public.division;
       public         heap    postgres    false         �            1259    16508    division_earnings    TABLE       CREATE TABLE public.division_earnings (
    earning_month date NOT NULL,
    uts_sub_urban_pass double precision DEFAULT 0 NOT NULL,
    uts_non_sub_pass double precision DEFAULT 0 NOT NULL,
    prs_pass double precision DEFAULT 0 NOT NULL,
    total_pass double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    other_coaching double precision DEFAULT 0 NOT NULL,
    total double precision DEFAULT 0 NOT NULL,
    sundry double precision DEFAULT 0 NOT NULL,
    gross_total double precision DEFAULT 0 NOT NULL,
    division_code character varying(5),
    total_passengers double precision DEFAULT 0 NOT NULL,
    sub_passengers double precision DEFAULT 0 NOT NULL,
    non_sub_passengers double precision DEFAULT 0 NOT NULL,
    id integer NOT NULL
);
 %   DROP TABLE public.division_earnings;
       public         heap    postgres    false         �            1259    16566    division_earnings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.division_earnings_id_seq;
       public          postgres    false    218         �           0    0    division_earnings_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.division_earnings_id_seq OWNED BY public.division_earnings.id;
          public          postgres    false    221         �            1259    16721    division_footfall    TABLE     �  CREATE TABLE public.division_footfall (
    id integer NOT NULL,
    earning_year date NOT NULL,
    uts_iw integer DEFAULT 0 NOT NULL,
    uts_ow integer DEFAULT 0 NOT NULL,
    prs_iw integer DEFAULT 0 NOT NULL,
    prs_ow integer DEFAULT 0 NOT NULL,
    total_iw integer DEFAULT 0 NOT NULL,
    total_ow integer DEFAULT 0,
    prs_daily_avg integer DEFAULT 0,
    uts_prs_daily_avg integer DEFAULT 0,
    station_code character varying(5),
    division_code character varying(5)
);
 %   DROP TABLE public.division_footfall;
       public         heap    postgres    false         �            1259    16720    division_footfall_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_footfall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.division_footfall_id_seq;
       public          postgres    false    235         �           0    0    division_footfall_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.division_footfall_id_seq OWNED BY public.division_footfall.id;
          public          postgres    false    234         �            1259    16625     division_goods_commodity_outward    TABLE     �  CREATE TABLE public.division_goods_commodity_outward (
    id integer NOT NULL,
    earning_year date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    commodity character varying(30) NOT NULL,
    division_code character varying(5) NOT NULL
);
 4   DROP TABLE public.division_goods_commodity_outward;
       public         heap    postgres    false         �            1259    16624 '   division_goods_commodity_outward_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_commodity_outward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.division_goods_commodity_outward_id_seq;
       public          postgres    false    227         �           0    0 '   division_goods_commodity_outward_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.division_goods_commodity_outward_id_seq OWNED BY public.division_goods_commodity_outward.id;
          public          postgres    false    226         �            1259    16748 &   division_goods_depowise_inward_traffic    TABLE     U  CREATE TABLE public.division_goods_depowise_inward_traffic (
    id integer NOT NULL,
    earning_year date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    station_code character varying(5),
    division_code character varying(5)
);
 :   DROP TABLE public.division_goods_depowise_inward_traffic;
       public         heap    postgres    false         �            1259    16747 -   division_goods_depowise_inward_traffic_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_depowise_inward_traffic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.division_goods_depowise_inward_traffic_id_seq;
       public          postgres    false    237         �           0    0 -   division_goods_depowise_inward_traffic_id_seq    SEQUENCE OWNED BY        ALTER SEQUENCE public.division_goods_depowise_inward_traffic_id_seq OWNED BY public.division_goods_depowise_inward_traffic.id;
          public          postgres    false    236         �            1259    16647 &   division_goods_depowise_yearly_earning    TABLE     �  CREATE TABLE public.division_goods_depowise_yearly_earning (
    id integer NOT NULL,
    earning_year date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    station_code character varying(5) NOT NULL,
    division_code character varying(5)
);
 :   DROP TABLE public.division_goods_depowise_yearly_earning;
       public         heap    postgres    false         �            1259    16646 -   division_goods_depowise_yearly_earning_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_depowise_yearly_earning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.division_goods_depowise_yearly_earning_id_seq;
       public          postgres    false    229         �           0    0 -   division_goods_depowise_yearly_earning_id_seq    SEQUENCE OWNED BY        ALTER SEQUENCE public.division_goods_depowise_yearly_earning_id_seq OWNED BY public.division_goods_depowise_yearly_earning.id;
          public          postgres    false    228         �            1259    16603    division_goods_monthwise_inward    TABLE     (  CREATE TABLE public.division_goods_monthwise_inward (
    id integer NOT NULL,
    earning_month date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 3   DROP TABLE public.division_goods_monthwise_inward;
       public         heap    postgres    false         �            1259    16602 &   division_goods_monthwise_inward_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_monthwise_inward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.division_goods_monthwise_inward_id_seq;
       public          postgres    false    225         �           0    0 &   division_goods_monthwise_inward_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.division_goods_monthwise_inward_id_seq OWNED BY public.division_goods_monthwise_inward.id;
          public          postgres    false    224         �            1259    16579     division_goods_monthwise_outward    TABLE     Z  CREATE TABLE public.division_goods_monthwise_outward (
    id integer NOT NULL,
    earning_month date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 4   DROP TABLE public.division_goods_monthwise_outward;
       public         heap    postgres    false         �            1259    16578 '   division_goods_monthwise_outward_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_monthwise_outward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.division_goods_monthwise_outward_id_seq;
       public          postgres    false    223         �           0    0 '   division_goods_monthwise_outward_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.division_goods_monthwise_outward_id_seq OWNED BY public.division_goods_monthwise_outward.id;
          public          postgres    false    222         �            1259    16770 !   division_parcel_earning_monthwise    TABLE     F  CREATE TABLE public.division_parcel_earning_monthwise (
    id integer NOT NULL,
    earning_year date NOT NULL,
    item character varying(30) DEFAULT 0 NOT NULL,
    packages integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    revenue integer DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 5   DROP TABLE public.division_parcel_earning_monthwise;
       public         heap    postgres    false         �            1259    16790 2   division_parcel_earning_monthwise_comparative_lugg    TABLE     %  CREATE TABLE public.division_parcel_earning_monthwise_comparative_lugg (
    id integer NOT NULL,
    earning_month date NOT NULL,
    packages integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    revenue integer DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 F   DROP TABLE public.division_parcel_earning_monthwise_comparative_lugg;
       public         heap    postgres    false         �            1259    16789 9   division_parcel_earning_monthwise_comparative_lugg_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 P   DROP SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq;
       public          postgres    false    241         �           0    0 9   division_parcel_earning_monthwise_comparative_lugg_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq OWNED BY public.division_parcel_earning_monthwise_comparative_lugg.id;
          public          postgres    false    240         �            1259    16769 (   division_parcel_earning_monthwise_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_parcel_earning_monthwise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.division_parcel_earning_monthwise_id_seq;
       public          postgres    false    239         �           0    0 (   division_parcel_earning_monthwise_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.division_parcel_earning_monthwise_id_seq OWNED BY public.division_parcel_earning_monthwise.id;
          public          postgres    false    238         �            1259    16531    division_target    TABLE     s  CREATE TABLE public.division_target (
    earning_id integer NOT NULL,
    earning_month date NOT NULL,
    uts_sub_urban_pass double precision DEFAULT 0 NOT NULL,
    non_sub_pass double precision DEFAULT 0 NOT NULL,
    total_pass double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    other_coaching double precision DEFAULT 0 NOT NULL,
    total double precision DEFAULT 0 NOT NULL,
    sundry double precision DEFAULT 0 NOT NULL,
    gross_total double precision DEFAULT 0 NOT NULL,
    sub_passengers double precision DEFAULT 0 NOT NULL,
    non_sub_passengers double precision DEFAULT 0 NOT NULL,
    total_passengers double precision DEFAULT 0 NOT NULL,
    division_code character varying(5),
    tc_cases bigint DEFAULT 0 NOT NULL,
    tc_amt double precision DEFAULT 0 NOT NULL,
    parcel_earning double precision DEFAULT 0 NOT NULL
);
 #   DROP TABLE public.division_target;
       public         heap    postgres    false         �           0    0    COLUMN division_target.tc_cases    COMMENT     U   COMMENT ON COLUMN public.division_target.tc_cases IS 'tecket checking target cases';
          public          postgres    false    220         �           0    0    COLUMN division_target.tc_amt    COMMENT     T   COMMENT ON COLUMN public.division_target.tc_amt IS 'ticket checking target amount';
          public          postgres    false    220         �           0    0 %   COLUMN division_target.parcel_earning    COMMENT     T   COMMENT ON COLUMN public.division_target.parcel_earning IS 'parcel earning target';
          public          postgres    false    220         �            1259    16530    division_target_earning_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_target_earning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.division_target_earning_id_seq;
       public          postgres    false    220         �           0    0    division_target_earning_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.division_target_earning_id_seq OWNED BY public.division_target.earning_id;
          public          postgres    false    219         �            1259    16681 $   division_tc_monthwise_cases_earnings    TABLE     Y  CREATE TABLE public.division_tc_monthwise_cases_earnings (
    id integer NOT NULL,
    earning_month date NOT NULL,
    cases integer DEFAULT 0 NOT NULL,
    amount double precision DEFAULT 0 NOT NULL,
    cases_target integer DEFAULT 0 NOT NULL,
    amount_target double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 8   DROP TABLE public.division_tc_monthwise_cases_earnings;
       public         heap    postgres    false         �            1259    16680 +   division_tc_monthwise_cases_earnings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq;
       public          postgres    false    231         �           0    0 +   division_tc_monthwise_cases_earnings_id_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq OWNED BY public.division_tc_monthwise_cases_earnings.id;
          public          postgres    false    230         �            1259    16699 !   division_tc_statement_of_earnings    TABLE     �  CREATE TABLE public.division_tc_statement_of_earnings (
    id integer NOT NULL,
    earning_month date NOT NULL,
    pwt_cases integer DEFAULT 0 NOT NULL,
    pwt_amt double precision DEFAULT 0 NOT NULL,
    irregular_cases integer DEFAULT 0 NOT NULL,
    irregular_amt double precision DEFAULT 0 NOT NULL,
    ubl_cases integer DEFAULT 0 NOT NULL,
    ubl_amt double precision DEFAULT 0,
    division_code character varying(5)
);
 5   DROP TABLE public.division_tc_statement_of_earnings;
       public         heap    postgres    false         �            1259    16698 (   division_tc_statement_of_earnings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_tc_statement_of_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.division_tc_statement_of_earnings_id_seq;
       public          postgres    false    233         �           0    0 (   division_tc_statement_of_earnings_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.division_tc_statement_of_earnings_id_seq OWNED BY public.division_tc_statement_of_earnings.id;
          public          postgres    false    232         �            1259    16491    station    TABLE     L  CREATE TABLE public.station (
    station_code character varying(5) NOT NULL,
    station_name character varying(255) NOT NULL,
    division_code character varying(5) NOT NULL,
    siding_flag integer DEFAULT 0 NOT NULL,
    sdg_serving_stn character varying(40),
    category character varying(20) DEFAULT 0 NOT NULL,
    state character varying(30) DEFAULT 0 NOT NULL,
    km_from_csmt double precision DEFAULT 0 NOT NULL,
    numerical_code bigint DEFAULT 0 NOT NULL,
    name_of_mp character varying(40) DEFAULT 0 NOT NULL,
    name_of_mla character varying(40) DEFAULT 0 NOT NULL
);
    DROP TABLE public.station;
       public         heap    postgres    false         �           0    0    COLUMN station.category    COMMENT     L   COMMENT ON COLUMN public.station.category IS 'station category by earning';
          public          postgres    false    217         �           0    0    COLUMN station.km_from_csmt    COMMENT     K   COMMENT ON COLUMN public.station.km_from_csmt IS 'kilometer from csmt/Hq';
          public          postgres    false    217         �           0    0    COLUMN station.name_of_mla    COMMENT     L   COMMENT ON COLUMN public.station.name_of_mla IS 'mla name of station area';
          public          postgres    false    217         �           2604    16567    division_earnings id    DEFAULT     |   ALTER TABLE ONLY public.division_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_earnings_id_seq'::regclass);
 C   ALTER TABLE public.division_earnings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    218         �           2604    16724    division_footfall id    DEFAULT     |   ALTER TABLE ONLY public.division_footfall ALTER COLUMN id SET DEFAULT nextval('public.division_footfall_id_seq'::regclass);
 C   ALTER TABLE public.division_footfall ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235         �           2604    16628 #   division_goods_commodity_outward id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_commodity_outward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_commodity_outward_id_seq'::regclass);
 R   ALTER TABLE public.division_goods_commodity_outward ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227         �           2604    16751 )   division_goods_depowise_inward_traffic id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic ALTER COLUMN id SET DEFAULT nextval('public.division_goods_depowise_inward_traffic_id_seq'::regclass);
 X   ALTER TABLE public.division_goods_depowise_inward_traffic ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236    237         �           2604    16650 )   division_goods_depowise_yearly_earning id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning ALTER COLUMN id SET DEFAULT nextval('public.division_goods_depowise_yearly_earning_id_seq'::regclass);
 X   ALTER TABLE public.division_goods_depowise_yearly_earning ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229         �           2604    16606 "   division_goods_monthwise_inward id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_monthwise_inward_id_seq'::regclass);
 Q   ALTER TABLE public.division_goods_monthwise_inward ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225         �           2604    16582 #   division_goods_monthwise_outward id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_monthwise_outward_id_seq'::regclass);
 R   ALTER TABLE public.division_goods_monthwise_outward ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223         �           2604    16773 $   division_parcel_earning_monthwise id    DEFAULT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise ALTER COLUMN id SET DEFAULT nextval('public.division_parcel_earning_monthwise_id_seq'::regclass);
 S   ALTER TABLE public.division_parcel_earning_monthwise ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239         �           2604    16793 5   division_parcel_earning_monthwise_comparative_lugg id    DEFAULT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg ALTER COLUMN id SET DEFAULT nextval('public.division_parcel_earning_monthwise_comparative_lugg_id_seq'::regclass);
 d   ALTER TABLE public.division_parcel_earning_monthwise_comparative_lugg ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    241    241         �           2604    16534    division_target earning_id    DEFAULT     �   ALTER TABLE ONLY public.division_target ALTER COLUMN earning_id SET DEFAULT nextval('public.division_target_earning_id_seq'::regclass);
 I   ALTER TABLE public.division_target ALTER COLUMN earning_id DROP DEFAULT;
       public          postgres    false    219    220    220         �           2604    16684 '   division_tc_monthwise_cases_earnings id    DEFAULT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_tc_monthwise_cases_earnings_id_seq'::regclass);
 V   ALTER TABLE public.division_tc_monthwise_cases_earnings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231         �           2604    16702 $   division_tc_statement_of_earnings id    DEFAULT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_tc_statement_of_earnings_id_seq'::regclass);
 S   ALTER TABLE public.division_tc_statement_of_earnings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233         �          0    16479    division 
   TABLE DATA           f   COPY public.division (division_code, division_name, railway_code, location, contact_info) FROM stdin;
    public          postgres    false    216       5058.dat �          0    16508    division_earnings 
   TABLE DATA           �   COPY public.division_earnings (earning_month, uts_sub_urban_pass, uts_non_sub_pass, prs_pass, total_pass, freight, other_coaching, total, sundry, gross_total, division_code, total_passengers, sub_passengers, non_sub_passengers, id) FROM stdin;
    public          postgres    false    218       5060.dat �          0    16721    division_footfall 
   TABLE DATA           �   COPY public.division_footfall (id, earning_year, uts_iw, uts_ow, prs_iw, prs_ow, total_iw, total_ow, prs_daily_avg, uts_prs_daily_avg, station_code, division_code) FROM stdin;
    public          postgres    false    235       5077.dat �          0    16625     division_goods_commodity_outward 
   TABLE DATA           �   COPY public.division_goods_commodity_outward (id, earning_year, rakes, wagon, weight, freight, commodity, division_code) FROM stdin;
    public          postgres    false    227       5069.dat �          0    16748 &   division_goods_depowise_inward_traffic 
   TABLE DATA           �   COPY public.division_goods_depowise_inward_traffic (id, earning_year, rakes, wagon, weight, station_code, division_code) FROM stdin;
    public          postgres    false    237       5079.dat �          0    16647 &   division_goods_depowise_yearly_earning 
   TABLE DATA           �   COPY public.division_goods_depowise_yearly_earning (id, earning_year, rakes, wagon, weight, freight, station_code, division_code) FROM stdin;
    public          postgres    false    229       5071.dat �          0    16603    division_goods_monthwise_inward 
   TABLE DATA           q   COPY public.division_goods_monthwise_inward (id, earning_month, rakes, wagon, weight, division_code) FROM stdin;
    public          postgres    false    225       5067.dat �          0    16579     division_goods_monthwise_outward 
   TABLE DATA           {   COPY public.division_goods_monthwise_outward (id, earning_month, rakes, wagon, weight, freight, division_code) FROM stdin;
    public          postgres    false    223       5065.dat �          0    16770 !   division_parcel_earning_monthwise 
   TABLE DATA           }   COPY public.division_parcel_earning_monthwise (id, earning_year, item, packages, weight, revenue, division_code) FROM stdin;
    public          postgres    false    239       5081.dat �          0    16790 2   division_parcel_earning_monthwise_comparative_lugg 
   TABLE DATA           �   COPY public.division_parcel_earning_monthwise_comparative_lugg (id, earning_month, packages, weight, revenue, division_code) FROM stdin;
    public          postgres    false    241       5083.dat �          0    16531    division_target 
   TABLE DATA             COPY public.division_target (earning_id, earning_month, uts_sub_urban_pass, non_sub_pass, total_pass, freight, other_coaching, total, sundry, gross_total, sub_passengers, non_sub_passengers, total_passengers, division_code, tc_cases, tc_amt, parcel_earning) FROM stdin;
    public          postgres    false    220       5062.dat �          0    16681 $   division_tc_monthwise_cases_earnings 
   TABLE DATA           �   COPY public.division_tc_monthwise_cases_earnings (id, earning_month, cases, amount, cases_target, amount_target, division_code) FROM stdin;
    public          postgres    false    231       5073.dat �          0    16699 !   division_tc_statement_of_earnings 
   TABLE DATA           �   COPY public.division_tc_statement_of_earnings (id, earning_month, pwt_cases, pwt_amt, irregular_cases, irregular_amt, ubl_cases, ubl_amt, division_code) FROM stdin;
    public          postgres    false    233       5075.dat �          0    16491    station 
   TABLE DATA           �   COPY public.station (station_code, station_name, division_code, siding_flag, sdg_serving_stn, category, state, km_from_csmt, numerical_code, name_of_mp, name_of_mla) FROM stdin;
    public          postgres    false    217       5059.dat �           0    0    division_earnings_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.division_earnings_id_seq', 22, true);
          public          postgres    false    221         �           0    0    division_footfall_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.division_footfall_id_seq', 1, false);
          public          postgres    false    234         �           0    0 '   division_goods_commodity_outward_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.division_goods_commodity_outward_id_seq', 73, true);
          public          postgres    false    226         �           0    0 -   division_goods_depowise_inward_traffic_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.division_goods_depowise_inward_traffic_id_seq', 1, false);
          public          postgres    false    236         �           0    0 -   division_goods_depowise_yearly_earning_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.division_goods_depowise_yearly_earning_id_seq', 42, true);
          public          postgres    false    228         �           0    0 &   division_goods_monthwise_inward_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.division_goods_monthwise_inward_id_seq', 1, false);
          public          postgres    false    224         �           0    0 '   division_goods_monthwise_outward_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.division_goods_monthwise_outward_id_seq', 22, true);
          public          postgres    false    222         �           0    0 9   division_parcel_earning_monthwise_comparative_lugg_id_seq    SEQUENCE SET     h   SELECT pg_catalog.setval('public.division_parcel_earning_monthwise_comparative_lugg_id_seq', 1, false);
          public          postgres    false    240         �           0    0 (   division_parcel_earning_monthwise_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.division_parcel_earning_monthwise_id_seq', 1, false);
          public          postgres    false    238         �           0    0    division_target_earning_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.division_target_earning_id_seq', 1, false);
          public          postgres    false    219         �           0    0 +   division_tc_monthwise_cases_earnings_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.division_tc_monthwise_cases_earnings_id_seq', 2, true);
          public          postgres    false    230         �           0    0 (   division_tc_statement_of_earnings_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.division_tc_statement_of_earnings_id_seq', 1, false);
          public          postgres    false    232         �           2606    16490 1   division division_division_code_division_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_division_code_division_name_key UNIQUE (division_code, division_name);
 [   ALTER TABLE ONLY public.division DROP CONSTRAINT division_division_code_division_name_key;
       public            postgres    false    216    216         �           2606    16488 #   division division_division_name_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_division_name_key UNIQUE (division_name);
 M   ALTER TABLE ONLY public.division DROP CONSTRAINT division_division_name_key;
       public            postgres    false    216         �           2606    16557 C   division_earnings division_earnings_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_division_code_earning_month_key UNIQUE (division_code, earning_month);
 m   ALTER TABLE ONLY public.division_earnings DROP CONSTRAINT division_earnings_division_code_earning_month_key;
       public            postgres    false    218    218         �           2606    16569 (   division_earnings division_earnings_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.division_earnings DROP CONSTRAINT division_earnings_pkey;
       public            postgres    false    218                    2606    16736 O   division_footfall division_footfall_division_code_station_code_earning_year_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_division_code_station_code_earning_year_key UNIQUE (division_code, station_code, earning_year);
 y   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_division_code_station_code_earning_year_key;
       public            postgres    false    235    235    235                    2606    16734 (   division_footfall division_footfall_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_pkey;
       public            postgres    false    235                    2606    16640 `   division_goods_commodity_outward division_goods_commodity_outw_division_code_earning_year_co_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outw_division_code_earning_year_co_key UNIQUE (division_code, earning_year, commodity);
 �   ALTER TABLE ONLY public.division_goods_commodity_outward DROP CONSTRAINT division_goods_commodity_outw_division_code_earning_year_co_key;
       public            postgres    false    227    227    227                    2606    16638 F   division_goods_commodity_outward division_goods_commodity_outward_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outward_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.division_goods_commodity_outward DROP CONSTRAINT division_goods_commodity_outward_pkey;
       public            postgres    false    227                    2606    16758 f   division_goods_depowise_inward_traffic division_goods_depowise_inwar_division_code_earning_year_st_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inwar_division_code_earning_year_st_key UNIQUE (division_code, earning_year, station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inwar_division_code_earning_year_st_key;
       public            postgres    false    237    237    237                    2606    16756 R   division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inward_traffic_pkey;
       public            postgres    false    237                    2606    16662 f   division_goods_depowise_yearly_earning division_goods_depowise_yearl_division_code_earning_year_st_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearl_division_code_earning_year_st_key UNIQUE (division_code, earning_year, station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearl_division_code_earning_year_st_key;
       public            postgres    false    229    229    229         
           2606    16660 R   division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearly_earning_pkey;
       public            postgres    false    229                     2606    16618 _   division_goods_monthwise_inward division_goods_monthwise_inward_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_goods_monthwise_inward DROP CONSTRAINT division_goods_monthwise_inward_division_code_earning_month_key;
       public            postgres    false    225    225                    2606    16616 D   division_goods_monthwise_inward division_goods_monthwise_inward_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.division_goods_monthwise_inward DROP CONSTRAINT division_goods_monthwise_inward_pkey;
       public            postgres    false    225         �           2606    16596 `   division_goods_monthwise_outward division_goods_monthwise_outwar_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outwar_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_goods_monthwise_outward DROP CONSTRAINT division_goods_monthwise_outwar_division_code_earning_month_key;
       public            postgres    false    223    223         �           2606    16594 F   division_goods_monthwise_outward division_goods_monthwise_outward_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outward_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.division_goods_monthwise_outward DROP CONSTRAINT division_goods_monthwise_outward_pkey;
       public            postgres    false    223                     2606    16800 r   division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwi_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwi_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg DROP CONSTRAINT division_parcel_earning_monthwi_division_code_earning_month_key;
       public            postgres    false    241    241                    2606    16781 a   division_parcel_earning_monthwise division_parcel_earning_monthwis_division_code_earning_year_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwis_division_code_earning_year_key UNIQUE (division_code, earning_year);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise DROP CONSTRAINT division_parcel_earning_monthwis_division_code_earning_year_key;
       public            postgres    false    239    239         "           2606    16798 j   division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwise_comparative_lugg_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwise_comparative_lugg_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg DROP CONSTRAINT division_parcel_earning_monthwise_comparative_lugg_pkey;
       public            postgres    false    241                    2606    16779 H   division_parcel_earning_monthwise division_parcel_earning_monthwise_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwise_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.division_parcel_earning_monthwise DROP CONSTRAINT division_parcel_earning_monthwise_pkey;
       public            postgres    false    239         �           2606    16486    division division_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_pkey PRIMARY KEY (division_code);
 @   ALTER TABLE ONLY public.division DROP CONSTRAINT division_pkey;
       public            postgres    false    216         �           2606    16549 ?   division_target division_target_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_division_code_earning_month_key UNIQUE (division_code, earning_month);
 i   ALTER TABLE ONLY public.division_target DROP CONSTRAINT division_target_division_code_earning_month_key;
       public            postgres    false    220    220         �           2606    16547 $   division_target division_target_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_pkey PRIMARY KEY (earning_id);
 N   ALTER TABLE ONLY public.division_target DROP CONSTRAINT division_target_pkey;
       public            postgres    false    220                    2606    16692 d   division_tc_monthwise_cases_earnings division_tc_monthwise_cases_ear_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_ear_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings DROP CONSTRAINT division_tc_monthwise_cases_ear_division_code_earning_month_key;
       public            postgres    false    231    231                    2606    16690 N   division_tc_monthwise_cases_earnings division_tc_monthwise_cases_earnings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_earnings_pkey PRIMARY KEY (id);
 x   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings DROP CONSTRAINT division_tc_monthwise_cases_earnings_pkey;
       public            postgres    false    231                    2606    16712 a   division_tc_statement_of_earnings division_tc_statement_of_earnin_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnin_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_tc_statement_of_earnings DROP CONSTRAINT division_tc_statement_of_earnin_division_code_earning_month_key;
       public            postgres    false    233    233                    2606    16710 H   division_tc_statement_of_earnings division_tc_statement_of_earnings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnings_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.division_tc_statement_of_earnings DROP CONSTRAINT division_tc_statement_of_earnings_pkey;
       public            postgres    false    233         �           2606    16501 ;   station station_division_code_station_code_station_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_division_code_station_code_station_name_key UNIQUE (division_code, station_code, station_name);
 e   ALTER TABLE ONLY public.station DROP CONSTRAINT station_division_code_station_code_station_name_key;
       public            postgres    false    217    217    217         �           2606    16497    station station_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_code);
 >   ALTER TABLE ONLY public.station DROP CONSTRAINT station_pkey;
       public            postgres    false    217         $           2606    16525 6   division_earnings division_earnings_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 `   ALTER TABLE ONLY public.division_earnings DROP CONSTRAINT division_earnings_division_code_fkey;
       public          postgres    false    216    218    4846         -           2606    16742 6   division_footfall division_footfall_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 `   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_division_code_fkey;
       public          postgres    false    4846    235    216         .           2606    16737 5   division_footfall division_footfall_station_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);
 _   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_station_code_fkey;
       public          postgres    false    217    4850    235         (           2606    16641 T   division_goods_commodity_outward division_goods_commodity_outward_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 ~   ALTER TABLE ONLY public.division_goods_commodity_outward DROP CONSTRAINT division_goods_commodity_outward_division_code_fkey;
       public          postgres    false    227    4846    216         /           2606    16764 `   division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inward_traffic_division_code_fkey;
       public          postgres    false    216    4846    237         0           2606    16759 _   division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_station_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inward_traffic_station_code_fkey;
       public          postgres    false    237    217    4850         )           2606    16668 `   division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearly_earning_division_code_fkey;
       public          postgres    false    216    229    4846         *           2606    16663 _   division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_station_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearly_earning_station_code_fkey;
       public          postgres    false    217    229    4850         '           2606    16619 R   division_goods_monthwise_inward division_goods_monthwise_inward_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 |   ALTER TABLE ONLY public.division_goods_monthwise_inward DROP CONSTRAINT division_goods_monthwise_inward_division_code_fkey;
       public          postgres    false    225    4846    216         &           2606    16597 T   division_goods_monthwise_outward division_goods_monthwise_outward_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 ~   ALTER TABLE ONLY public.division_goods_monthwise_outward DROP CONSTRAINT division_goods_monthwise_outward_division_code_fkey;
       public          postgres    false    216    223    4846         2           2606    16801 r   division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwise_comparativ_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwise_comparativ_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg DROP CONSTRAINT division_parcel_earning_monthwise_comparativ_division_code_fkey;
       public          postgres    false    241    216    4846         1           2606    16782 V   division_parcel_earning_monthwise division_parcel_earning_monthwise_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwise_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise DROP CONSTRAINT division_parcel_earning_monthwise_division_code_fkey;
       public          postgres    false    239    4846    216         %           2606    16550 2   division_target division_target_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 \   ALTER TABLE ONLY public.division_target DROP CONSTRAINT division_target_division_code_fkey;
       public          postgres    false    4846    216    220         +           2606    16693 \   division_tc_monthwise_cases_earnings division_tc_monthwise_cases_earnings_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings DROP CONSTRAINT division_tc_monthwise_cases_earnings_division_code_fkey;
       public          postgres    false    231    4846    216         ,           2606    16713 V   division_tc_statement_of_earnings division_tc_statement_of_earnings_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_tc_statement_of_earnings DROP CONSTRAINT division_tc_statement_of_earnings_division_code_fkey;
       public          postgres    false    4846    216    233         #           2606    16502 "   station station_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 L   ALTER TABLE ONLY public.station DROP CONSTRAINT station_division_code_fkey;
       public          postgres    false    217    216    4846                                                  5058.dat                                                                                            0000600 0004000 0002000 00000000106 14600074532 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        pune	Pune	CR	Location 1	123456
sur	Solapur	CR	Location 2	8736789
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                          5060.dat                                                                                            0000600 0004000 0002000 00000003634 14600074532 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2022-04-01	0.65	1.79	70.61	73.05	28.34	8.58	109.97	0.76	110.72	pune	29.13111	11.39	17.74	1
2022-05-01	0.84	2.6	72.3	75.74	25.69	9.63	111.05	0.55	111.61	pune	31.91386	13.59	18.32	2
2022-06-01	0.86	3.14	73.74	77.74	35.26	11.64	124.64	1.14	125.78	pune	33.09	14.02	19.08	3
2022-08-01	1	10.66	74.07	85.73	34.4	7.83	127.95	1.27	129.22	pune	38.74	15.67	23.07	4
2022-09-01	1.02	11.72	73.28	86.01	38.91	8.36	133.28	2.95	136.23	pune	42.09	17.57	24.53	5
2022-10-01	1	15.36	63.43	79.79	30.02	9.57	119.39	0.99	120.38	pune	41.56	16.11	25.45	6
2022-11-01	1.08	14.4	75.32	90.8	43.15	8.64	142.6	2.13	144.73	pune	46	18.49	27.51	7
2022-12-01	1.06	15.19	75.17	91.42	36.83	9.08	137.33	1.95	139.28	pune	44.72	17.72	27	8
2023-01-01	0.99	14.92	78.5	93.45	28.82	7.98	130.25	1.1	131.35	pune	45.22	17.63	27.58	9
2023-02-01	0.97	14.42	73.47	88.86	28.25	7.55	124.66	1.99	126.65	pune	40.95	16.41	24.54	10
2023-03-01	1.03	14.62	77.65	93.3	32.89	8.76	134.96	2.14	137.1	pune	44.25	17.33	24.54	11
2023-04-01	1.08	17.52	69.48	88.08	30.74	9.81	128.63	1.23	129.86	pune	44.02959	16.99	27.04	12
2023-05-01	1.19	19.2	73.73	94.12	28.04	9.95	132.1	1.31	133.42	pune	46.8	17.78	29.02	13
2023-06-01	1.13	16.26	72.58	89.98	36.14	10.1	136.22	1.78	137.99	pune	43.93	17.41	26.52	14
2023-08-01	1.27	15.63	87.97	104.87	43.98	9.54	158.39	1.86	160.25	pune	49.23	20.03	29.2	15
2023-09-01	1.16	15.3	79.61	96.08	40.17	11.35	147.6	1.58	149.18	pune	46.4	18.96	29.2	16
2023-10-01	1.13	15.61	82.79	99.53	42.38	9.88	151.78	1.07	152.86	pune	47.09	18.92	28.17	17
2023-11-01	1.08	20.52	78.16	99.76	31.11	11.23	142.1	1.65	143.75	pune	46.99	17.07	29.93	18
2023-12-01	1.1	16.35	90.56	108.01	40.69	9.3	158	1.99	159.99	pune	46.76	17.16	29.93	19
2022-07-01	0.93	8.87	78.5	88.3	40.54	9.07	137.91	0.71	138.62	pune	36.37	14.24	22.13	20
2023-07-01	1.31	14.48	102.8	118.58	34.99	9.23	162.8	1.86	164.67	pune	47.6	18.94	28.67	21
2024-01-01	1.13	167.37	89.04	106.67	28.05	9.77	144.49	1.33	145.83	pune	47.5	18.56	28.94	22
\.


                                                                                                    5077.dat                                                                                            0000600 0004000 0002000 00000000005 14600074532 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           5069.dat                                                                                            0000600 0004000 0002000 00000002765 14600074532 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        36	2023-03-31	345	14208	900544	901097	SUGAR	pune
37	2023-03-31	355	17674	915587	1093616	POL	pune
38	2023-03-31	0	0	0	0	DRY GRASS	pune
39	2023-03-31	603	15416	785217	800236	AUTOMOBILE	pune
40	2023-03-31	0	0	0	0	IRON ORE	pune
41	2023-03-31	0	0	0	0	PIG IRON	pune
42	2023-03-31	0	0	0	0	BENTONITE POWDER	pune
43	2023-03-31	0	0	0	0	CEMENT	pune
44	2023-03-31	1	42	2661	2704	FOODGRAIN	pune
45	2023-03-31	0	0	0	0	IRON STEEL	pune
46	2023-03-31	0	0	0	0	FURNACE OIL	pune
47	2023-03-31	0	0	0	0	OTHER	pune
48	2023-03-31	2	42	2748	2792	FERTILIZER	pune
49	2023-03-31	216	4263	261458	265937	RMC	pune
50	2023-03-31	0	0	0	0	CONCOR	pune
51	2023-03-31	0	0	0	0	EMPTY CONTAINER	pune
52	2023-03-31	11	297	0	308	EMPTY HAULAGE RAKE	pune
53	2023-03-31	0	0	0	0	FLY ASH	pune
54	2023-03-31	0	0	0	0	JAGGERY	pune
55	2024-03-31	237	9304	592082.4	166.3	SUGAR	pune
56	2024-03-31	330	16391	852382	77	POL	pune
57	2024-03-31	0	0	0	0	DRY GRASS	pune
58	2024-03-31	745	18883	925551	135	AUTOMOBILE	pune
59	2024-03-31	0	0	0	0	IRON ORE	pune
60	2024-03-31	0	0	0	0	PIG IRON	pune
61	2024-03-31	0	0	0	0	BENTONITE POWDER	pune
62	2024-03-31	0	0	0	0	CEMENT	pune
63	2024-03-31	0	0	0	0	FOODGRAIN	pune
64	2024-03-31	0	0	0	0	IRON STEEL	pune
65	2024-03-31	0	0	0	0	FURNACE OIL	pune
66	2024-03-31	0	0	0	0	OTHER	pune
67	2024-03-31	0	0	0	0	FERTILIZER	pune
68	2024-03-31	0	0	0	0	RMC	pune
69	2024-03-31	0	0	0	0	CONCOR	pune
70	2024-03-31	0	0	0	0	EMPTY CONTAINER	pune
71	2024-03-31	0	0	0	0	EMPTY HAULAGE RAKE	pune
72	2024-03-31	0	0	0	0	FLY ASH	pune
73	2024-03-31	0	0	0	0	JAGGERY	pune
\.


           5079.dat                                                                                            0000600 0004000 0002000 00000000005 14600074532 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           5071.dat                                                                                            0000600 0004000 0002000 00000001734 14600074532 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        16	2023-03-31	410	10609	503528	71	cch	pune
17	2023-03-31	149	3532	207874	19	kk	pune
18	2023-03-31	99	4053	256969	49	grmt	pune
19	2023-03-31	74	1844	90964	9	loni	pune
20	2023-03-31	92	3146	198627	29	brmt	pune
21	2023-03-31	82	3423	216911	47	sli	pune
22	2023-03-31	96	2169	131763	10	mrj	pune
23	2023-03-31	61	2433	154305	28.9	krd	pune
24	2023-03-31	81	2122	133023	11	str	pune
25	2023-03-31	34	937	58664	4	lnn	pune
26	2023-03-31	0	0	0	0	ssv	pune
31	2024-03-31	391	10066	407753	84	cch	pune
32	2024-03-31	204	4876	287382	28	kk	pune
33	2024-03-31	72	2817	179404	51	grmt	pune
34	2024-03-31	180	4493	248311	25	loni	pune
35	2024-03-31	97	3108	196990	44	brmt	pune
36	2024-03-31	22	882	56133	16	sli	pune
37	2024-03-31	131	3012	189735	22	mrj	pune
38	2024-03-31	39	1413	89915	26	krd	pune
39	2024-03-31	64	1600	100361	16	str	pune
40	2024-03-31	24	441	27753	1	lnn	pune
41	2024-03-31	2	43	2952	0	ssv	pune
42	2024-03-31	311	15446	803212	74.73	hplg	pune
27	2023-03-31	321	16000	830333	83.21	hplg	pune
\.


                                    5067.dat                                                                                            0000600 0004000 0002000 00000000005 14600074532 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           5065.dat                                                                                            0000600 0004000 0002000 00000001563 14600074532 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2022-04-01	139	4733	268063	28.3	pune
2	2022-05-01	125	4405	253327	25.7	pune
3	2022-06-01	138	4886	281327	35.3	pune
4	2022-07-01	145	5102	282567	40.5	pune
5	2022-08-01	167	5350	288285	34.4	pune
6	2022-09-01	155	5216	284035	38.9	pune
7	2022-10-01	114	3657	194591	30	pune
8	2022-11-01	153	5318	297599	43.2	pune
9	2022-12-01	160	5269	286256	36.8	pune
10	2023-01-01	119	4000	220158	28.8	pune
11	2023-02-01	118	4006	212007	28.3	pune
12	2023-03-01	124	4089	215196	32.9	pune
13	2023-04-01	142	4350	233882	30.76	pune
14	2023-05-01	115	3581	189695	28.04	pune
15	2023-06-01	140	4185	221824	36.14	pune
16	2023-07-01	124	4088	211153	34.99	pune
17	2023-08-01	159	5343	284036	43.98	pune
18	2023-09-01	154	5063	275127	40.17	pune
19	2023-10-01	157	4968	273103	42.38	pune
20	2023-11-01	145	4420	237044	31.41	pune
21	2023-12-01	165	5246	283081	40.7	pune
22	2024-01-01	121	3845	210178	28.05	pune
\.


                                                                                                                                             5081.dat                                                                                            0000600 0004000 0002000 00000000005 14600074532 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           5083.dat                                                                                            0000600 0004000 0002000 00000000005 14600074532 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           5062.dat                                                                                            0000600 0004000 0002000 00000002174 14600074532 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2023-04-01	0.75	78.73	79.48	30.73	9.34	119.55	1.67	121.22	1.32	2.05	3.37	pune	33600	1.85	3.33
2	2023-05-01	0.98	81.14	82.12	29.03	12.49	123.64	1.67	125.31	1.57	2.12	3.69	pune	33930	1.85	4.09
3	2023-06-01	0.99	83.97	84.96	38.93	13.35	137.24	1.67	138.91	1.64	2.21	3.85	pune	27930	2.15	3.62
4	2023-07-01	1.06	96.04	97.1	44.73	10.13	151.96	1.67	153.63	1.64	2.56	4.2	pune	18700	1.55	4.11
5	2023-08-01	1.15	92.46	93.61	38.06	8.93	140.6	1.67	142.27	1.82	2.68	4.5	pune	19130	1.55	3.43
6	2023-09-01	1.17	93.11	94.28	42.91	11.65	148.84	1.67	150.51	2.04	2.85	4.89	pune	24140	1.9	3.95
7	2023-10-01	1.15	85.21	86.36	32.83	11.71	130.9	1.67	132.57	1.86	2.97	4.83	pune	29860	2.2	3.37
8	2023-11-01	1.24	98.28	99.52	47.54	9.47	156.53	1.67	158.2	2.15	3.2	5.35	pune	24280	2.4	3.48
9	2023-12-01	1.22	98.34	99.56	40.64	9.76	149.96	1.67	151.63	2.08	3.14	5.22	pune	21760	1.6	3.07
10	2024-01-01	1.22	102.2	103.42	31.64	9.21	144.27	1.67	145.94	2.06	3.21	5.27	pune	25470	1.8	2.6
11	2024-02-01	1.13	96.15	97.28	31.37	8.28	136.93	1.67	138.6	1.91	2.85	4.76	pune	25050	1.8	2.34
12	2024-03-01	1.2	100.83	102.03	36.29	9.71	148.03	1.67	149.7	2	3.13	5.13	pune	26390	1.85	3.02
\.


                                                                                                                                                                                                                                                                                                                                                                                                    5073.dat                                                                                            0000600 0004000 0002000 00000001552 14600074532 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2022-04-01	36953	2.48	0	0	pune
2	2022-05-01	37312	2.55	0	0	pune
3	2022-06-01	30714	2.05	0	0	pune
4	2022-07-01	20555	1.53	0	0	pune
5	2022-08-01	21044	1.53	0	0	pune
6	2022-09-01	26555	1.94	0	0	pune
7	2022-10-01	32841	2.64	0	0	pune
8	2022-11-01	26694	1.96	0	0	pune
9	2022-12-01	23934	1.7	0	0	pune
10	2023-01-01	28006	2.02	0	0	pune
11	2023-02-01	27547	2.13	0	0	pune
12	2023-03-01	29021	2.13	0	0	pune
13	2023-04-01	36962	2.8	33600	1.85	pune
14	2023-05-01	34152	2.76	33930	1.85	pune
15	2023-06-01	34018	2.65	27930	2.15	pune
16	2023-07-01	28784	2.02	18700	1.55	pune
17	2023-08-01	28484	1.95	19130	1.55	pune
18	2023-09-01	27142	1.97	24140	1.9	pune
19	2023-10-01	34045	2.65	29860	2.2	pune
20	2023-11-01	37892	3.09	24280	2.4	pune
21	2023-12-01	22529	1.56	21760	1.6	pune
22	2024-01-01	24732	1.73	25470	1.8	pune
23	2024-02-01	0	0	25050	1.8	pune
24	2024-03-01	0	0	26390	1.85	pune
\.


                                                                                                                                                      5075.dat                                                                                            0000600 0004000 0002000 00000002430 14600074532 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2022-04-01	36579	24748485	101	46625	273	32755	pune
2	2022-05-01	36936	25381114	89	45396	287	31285	pune
3	2022-06-01	30410	20389750	146	89225	158	17910	pune
4	2022-07-01	19829	15016355	545	288485	181	22245	pune
5	2022-08-01	19309	14404030	1524	826275	211	24360	pune
6	2022-09-01	22194	17080135	4052	2312260	309	35525	pune
7	2022-10-01	27031	23031772	5510	3281144	300	40980	pune
8	2022-11-01	21736	16873325	4709	2693800	249	37440	pune
9	2022-12-01	18234	13823595	5434	3141330	266	31040	pune
10	2023-01-01	20657	16084265	7103	4106715	246	26290	pune
11	2023-02-01	20533	17289025	6843	3978810	171	19545	pune
12	2023-03-01	21756	17223060	7050	4080960	215	23510	pune
13	2023-04-01	28167	2292244	8589	5069776	206	21350	pune
14	2023-05-01	26188	22740282	7825	4858728	139	14970	pune
15	2023-06-01	25377	21461960	8477	5095061	164	21175	pune
16	2023-07-01	20199	15343760	8435	488853	150	15410	pune
17	2023-08-01	19101	14356125	9149	5145090	234	26420	pune
18	2023-09-01	17622	14217685	9364	5528630	156	17150	pune
19	2023-10-01	23151	20310460	10709	6264370	185	20600	pune
20	2023-11-01	28301	25063754	9386	5850830	205	21240	pune
21	2023-12-01	16022	11860985	6308	3735290	199	25075	pune
22	2024-01-01	204128	168277455	78242	46436305	1638	183390	pune
23	2024-02-01	0	0	0	0	0	0	pune
24	2024-03-01	0	0	0	0	0	0	pune
\.


                                                                                                                                                                                                                                        5059.dat                                                                                            0000600 0004000 0002000 00000002417 14600074532 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        pune	Pune	pune	0	\N	0	0	0	0	0	0
sur	Solapur	sur	0	\N	0	0	0	0	0	0
bfsg	Bharat Forge	pune	1	Hadapsar	0	0	0	0	0	0
hplg	Hindustan Petroleum Oil	pune	1	Loni	0	0	0	0	0	0
cwhc	Central Warehouse	pune	1	Miraj	0	0	0	0	0	0
hplc	Hindustan Petroleum Oil	pune	1	Bhilavadi	0	0	0	0	0	0
ghsg	Grain Depot	pune	1	Ghorpuri	0	0	0	0	0	0
utcu	Ultra Tech Cement Ltd	pune	1	Uruli	0	0	0	0	0	0
ppcp	Penna Cement	pune	1	Patas	0	0	0	0	0	0
bpal	Bharat Petroleum Corp Ltd	pune	1	Alandi	0	0	0	0	0	0
scgp	M/S Shree Cement	pune	1	Patas	0	0	0	0	0	0
grmt	Gur Market	pune	0	\N	0	0	0	0	0	0
mrj	Miraj	pune	0	\N	0	0	0	0	0	0
sli	Sangli	pune	0	\N	0	0	0	0	0	0
ssv	Sasvad Road	pune	0	\N	0	0	0	0	0	0
loni	Loni	pune	0	\N	0	0	0	0	0	0
cch	Chinchwad	pune	0	\N	0	0	0	0	0	0
brmt	Baramati	pune	0	\N	0	0	0	0	0	0
krd	Karad	pune	0	\N	0	0	0	0	0	0
str	Satara	pune	0	\N	0	0	0	0	0	0
kk	Khadki	pune	0	\N	0	0	0	0	0	0
fsg	Phursungi	pune	0	\N	0	0	0	0	0	0
lnn	Lonand	pune	0	\N	0	0	0	0	0	0
kksg	Khadki Railway Station Siding	pune	2	Khadki	0	0	0	0	0	0
cafd	CAFVD Siding	pune	2	Khadki	0	0	0	0	0	0
kvsg	Armoured Vehicle Depot Siding	pune	2	Khadki	0	0	0	0	0	0
dasg	Dehuroad Yard, Danger Area Siding	pune	2	Dehu Road	0	0	0	0	0	0
cmsg	Ghorawadi Yard, DOD Depot Siding	pune	2	Dehu Road	0	0	0	0	0	0
cpsg	Begdewadi / Shelarwadi Siding	pune	2	Dehu Road	0	0	0	0	0	0
\.


                                                                                                                                                                                                                                                 restore.sql                                                                                         0000600 0004000 0002000 00000124601 14600074532 0015371 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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

DROP DATABASE railway_dashboard;
--
-- Name: railway_dashboard; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE railway_dashboard WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE railway_dashboard OWNER TO postgres;

\connect railway_dashboard

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
-- Name: divisions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA divisions;


ALTER SCHEMA divisions OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: division; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division (
    division_code character varying(5) NOT NULL,
    division_name character varying(30) NOT NULL,
    railway_code character varying(5) DEFAULT 'CR'::character varying NOT NULL,
    location character varying,
    contact_info character varying
);


ALTER TABLE public.division OWNER TO postgres;

--
-- Name: division_earnings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_earnings (
    earning_month date NOT NULL,
    uts_sub_urban_pass double precision DEFAULT 0 NOT NULL,
    uts_non_sub_pass double precision DEFAULT 0 NOT NULL,
    prs_pass double precision DEFAULT 0 NOT NULL,
    total_pass double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    other_coaching double precision DEFAULT 0 NOT NULL,
    total double precision DEFAULT 0 NOT NULL,
    sundry double precision DEFAULT 0 NOT NULL,
    gross_total double precision DEFAULT 0 NOT NULL,
    division_code character varying(5),
    total_passengers double precision DEFAULT 0 NOT NULL,
    sub_passengers double precision DEFAULT 0 NOT NULL,
    non_sub_passengers double precision DEFAULT 0 NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.division_earnings OWNER TO postgres;

--
-- Name: division_earnings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_earnings_id_seq OWNER TO postgres;

--
-- Name: division_earnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_earnings_id_seq OWNED BY public.division_earnings.id;


--
-- Name: division_footfall; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_footfall (
    id integer NOT NULL,
    earning_year date NOT NULL,
    uts_iw integer DEFAULT 0 NOT NULL,
    uts_ow integer DEFAULT 0 NOT NULL,
    prs_iw integer DEFAULT 0 NOT NULL,
    prs_ow integer DEFAULT 0 NOT NULL,
    total_iw integer DEFAULT 0 NOT NULL,
    total_ow integer DEFAULT 0,
    prs_daily_avg integer DEFAULT 0,
    uts_prs_daily_avg integer DEFAULT 0,
    station_code character varying(5),
    division_code character varying(5)
);


ALTER TABLE public.division_footfall OWNER TO postgres;

--
-- Name: division_footfall_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_footfall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_footfall_id_seq OWNER TO postgres;

--
-- Name: division_footfall_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_footfall_id_seq OWNED BY public.division_footfall.id;


--
-- Name: division_goods_commodity_outward; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_goods_commodity_outward (
    id integer NOT NULL,
    earning_year date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    commodity character varying(30) NOT NULL,
    division_code character varying(5) NOT NULL
);


ALTER TABLE public.division_goods_commodity_outward OWNER TO postgres;

--
-- Name: division_goods_commodity_outward_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_goods_commodity_outward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_goods_commodity_outward_id_seq OWNER TO postgres;

--
-- Name: division_goods_commodity_outward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_goods_commodity_outward_id_seq OWNED BY public.division_goods_commodity_outward.id;


--
-- Name: division_goods_depowise_inward_traffic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_goods_depowise_inward_traffic (
    id integer NOT NULL,
    earning_year date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    station_code character varying(5),
    division_code character varying(5)
);


ALTER TABLE public.division_goods_depowise_inward_traffic OWNER TO postgres;

--
-- Name: division_goods_depowise_inward_traffic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_goods_depowise_inward_traffic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_goods_depowise_inward_traffic_id_seq OWNER TO postgres;

--
-- Name: division_goods_depowise_inward_traffic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_goods_depowise_inward_traffic_id_seq OWNED BY public.division_goods_depowise_inward_traffic.id;


--
-- Name: division_goods_depowise_yearly_earning; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_goods_depowise_yearly_earning (
    id integer NOT NULL,
    earning_year date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    station_code character varying(5) NOT NULL,
    division_code character varying(5)
);


ALTER TABLE public.division_goods_depowise_yearly_earning OWNER TO postgres;

--
-- Name: division_goods_depowise_yearly_earning_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_goods_depowise_yearly_earning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_goods_depowise_yearly_earning_id_seq OWNER TO postgres;

--
-- Name: division_goods_depowise_yearly_earning_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_goods_depowise_yearly_earning_id_seq OWNED BY public.division_goods_depowise_yearly_earning.id;


--
-- Name: division_goods_monthwise_inward; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_goods_monthwise_inward (
    id integer NOT NULL,
    earning_month date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);


ALTER TABLE public.division_goods_monthwise_inward OWNER TO postgres;

--
-- Name: division_goods_monthwise_inward_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_goods_monthwise_inward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_goods_monthwise_inward_id_seq OWNER TO postgres;

--
-- Name: division_goods_monthwise_inward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_goods_monthwise_inward_id_seq OWNED BY public.division_goods_monthwise_inward.id;


--
-- Name: division_goods_monthwise_outward; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_goods_monthwise_outward (
    id integer NOT NULL,
    earning_month date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);


ALTER TABLE public.division_goods_monthwise_outward OWNER TO postgres;

--
-- Name: division_goods_monthwise_outward_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_goods_monthwise_outward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_goods_monthwise_outward_id_seq OWNER TO postgres;

--
-- Name: division_goods_monthwise_outward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_goods_monthwise_outward_id_seq OWNED BY public.division_goods_monthwise_outward.id;


--
-- Name: division_parcel_earning_monthwise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_parcel_earning_monthwise (
    id integer NOT NULL,
    earning_year date NOT NULL,
    item character varying(30) DEFAULT 0 NOT NULL,
    packages integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    revenue integer DEFAULT 0 NOT NULL,
    division_code character varying(5)
);


ALTER TABLE public.division_parcel_earning_monthwise OWNER TO postgres;

--
-- Name: division_parcel_earning_monthwise_comparative_lugg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_parcel_earning_monthwise_comparative_lugg (
    id integer NOT NULL,
    earning_month date NOT NULL,
    packages integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    revenue integer DEFAULT 0 NOT NULL,
    division_code character varying(5)
);


ALTER TABLE public.division_parcel_earning_monthwise_comparative_lugg OWNER TO postgres;

--
-- Name: division_parcel_earning_monthwise_comparative_lugg_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq OWNER TO postgres;

--
-- Name: division_parcel_earning_monthwise_comparative_lugg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq OWNED BY public.division_parcel_earning_monthwise_comparative_lugg.id;


--
-- Name: division_parcel_earning_monthwise_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_parcel_earning_monthwise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_parcel_earning_monthwise_id_seq OWNER TO postgres;

--
-- Name: division_parcel_earning_monthwise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_parcel_earning_monthwise_id_seq OWNED BY public.division_parcel_earning_monthwise.id;


--
-- Name: division_target; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_target (
    earning_id integer NOT NULL,
    earning_month date NOT NULL,
    uts_sub_urban_pass double precision DEFAULT 0 NOT NULL,
    non_sub_pass double precision DEFAULT 0 NOT NULL,
    total_pass double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    other_coaching double precision DEFAULT 0 NOT NULL,
    total double precision DEFAULT 0 NOT NULL,
    sundry double precision DEFAULT 0 NOT NULL,
    gross_total double precision DEFAULT 0 NOT NULL,
    sub_passengers double precision DEFAULT 0 NOT NULL,
    non_sub_passengers double precision DEFAULT 0 NOT NULL,
    total_passengers double precision DEFAULT 0 NOT NULL,
    division_code character varying(5),
    tc_cases bigint DEFAULT 0 NOT NULL,
    tc_amt double precision DEFAULT 0 NOT NULL,
    parcel_earning double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.division_target OWNER TO postgres;

--
-- Name: COLUMN division_target.tc_cases; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.division_target.tc_cases IS 'tecket checking target cases';


--
-- Name: COLUMN division_target.tc_amt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.division_target.tc_amt IS 'ticket checking target amount';


--
-- Name: COLUMN division_target.parcel_earning; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.division_target.parcel_earning IS 'parcel earning target';


--
-- Name: division_target_earning_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_target_earning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_target_earning_id_seq OWNER TO postgres;

--
-- Name: division_target_earning_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_target_earning_id_seq OWNED BY public.division_target.earning_id;


--
-- Name: division_tc_monthwise_cases_earnings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_tc_monthwise_cases_earnings (
    id integer NOT NULL,
    earning_month date NOT NULL,
    cases integer DEFAULT 0 NOT NULL,
    amount double precision DEFAULT 0 NOT NULL,
    cases_target integer DEFAULT 0 NOT NULL,
    amount_target double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);


ALTER TABLE public.division_tc_monthwise_cases_earnings OWNER TO postgres;

--
-- Name: division_tc_monthwise_cases_earnings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq OWNER TO postgres;

--
-- Name: division_tc_monthwise_cases_earnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq OWNED BY public.division_tc_monthwise_cases_earnings.id;


--
-- Name: division_tc_statement_of_earnings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division_tc_statement_of_earnings (
    id integer NOT NULL,
    earning_month date NOT NULL,
    pwt_cases integer DEFAULT 0 NOT NULL,
    pwt_amt double precision DEFAULT 0 NOT NULL,
    irregular_cases integer DEFAULT 0 NOT NULL,
    irregular_amt double precision DEFAULT 0 NOT NULL,
    ubl_cases integer DEFAULT 0 NOT NULL,
    ubl_amt double precision DEFAULT 0,
    division_code character varying(5)
);


ALTER TABLE public.division_tc_statement_of_earnings OWNER TO postgres;

--
-- Name: division_tc_statement_of_earnings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_tc_statement_of_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.division_tc_statement_of_earnings_id_seq OWNER TO postgres;

--
-- Name: division_tc_statement_of_earnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_tc_statement_of_earnings_id_seq OWNED BY public.division_tc_statement_of_earnings.id;


--
-- Name: station; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.station (
    station_code character varying(5) NOT NULL,
    station_name character varying(255) NOT NULL,
    division_code character varying(5) NOT NULL,
    siding_flag integer DEFAULT 0 NOT NULL,
    sdg_serving_stn character varying(40),
    category character varying(20) DEFAULT 0 NOT NULL,
    state character varying(30) DEFAULT 0 NOT NULL,
    km_from_csmt double precision DEFAULT 0 NOT NULL,
    numerical_code bigint DEFAULT 0 NOT NULL,
    name_of_mp character varying(40) DEFAULT 0 NOT NULL,
    name_of_mla character varying(40) DEFAULT 0 NOT NULL
);


ALTER TABLE public.station OWNER TO postgres;

--
-- Name: COLUMN station.category; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.station.category IS 'station category by earning';


--
-- Name: COLUMN station.km_from_csmt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.station.km_from_csmt IS 'kilometer from csmt/Hq';


--
-- Name: COLUMN station.name_of_mla; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.station.name_of_mla IS 'mla name of station area';


--
-- Name: division_earnings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_earnings_id_seq'::regclass);


--
-- Name: division_footfall id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_footfall ALTER COLUMN id SET DEFAULT nextval('public.division_footfall_id_seq'::regclass);


--
-- Name: division_goods_commodity_outward id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_commodity_outward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_commodity_outward_id_seq'::regclass);


--
-- Name: division_goods_depowise_inward_traffic id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_inward_traffic ALTER COLUMN id SET DEFAULT nextval('public.division_goods_depowise_inward_traffic_id_seq'::regclass);


--
-- Name: division_goods_depowise_yearly_earning id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_yearly_earning ALTER COLUMN id SET DEFAULT nextval('public.division_goods_depowise_yearly_earning_id_seq'::regclass);


--
-- Name: division_goods_monthwise_inward id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_inward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_monthwise_inward_id_seq'::regclass);


--
-- Name: division_goods_monthwise_outward id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_outward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_monthwise_outward_id_seq'::regclass);


--
-- Name: division_parcel_earning_monthwise id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise ALTER COLUMN id SET DEFAULT nextval('public.division_parcel_earning_monthwise_id_seq'::regclass);


--
-- Name: division_parcel_earning_monthwise_comparative_lugg id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg ALTER COLUMN id SET DEFAULT nextval('public.division_parcel_earning_monthwise_comparative_lugg_id_seq'::regclass);


--
-- Name: division_target earning_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_target ALTER COLUMN earning_id SET DEFAULT nextval('public.division_target_earning_id_seq'::regclass);


--
-- Name: division_tc_monthwise_cases_earnings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_tc_monthwise_cases_earnings_id_seq'::regclass);


--
-- Name: division_tc_statement_of_earnings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_statement_of_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_tc_statement_of_earnings_id_seq'::regclass);


--
-- Data for Name: division; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division (division_code, division_name, railway_code, location, contact_info) FROM stdin;
\.
COPY public.division (division_code, division_name, railway_code, location, contact_info) FROM '$$PATH$$/5058.dat';

--
-- Data for Name: division_earnings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_earnings (earning_month, uts_sub_urban_pass, uts_non_sub_pass, prs_pass, total_pass, freight, other_coaching, total, sundry, gross_total, division_code, total_passengers, sub_passengers, non_sub_passengers, id) FROM stdin;
\.
COPY public.division_earnings (earning_month, uts_sub_urban_pass, uts_non_sub_pass, prs_pass, total_pass, freight, other_coaching, total, sundry, gross_total, division_code, total_passengers, sub_passengers, non_sub_passengers, id) FROM '$$PATH$$/5060.dat';

--
-- Data for Name: division_footfall; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_footfall (id, earning_year, uts_iw, uts_ow, prs_iw, prs_ow, total_iw, total_ow, prs_daily_avg, uts_prs_daily_avg, station_code, division_code) FROM stdin;
\.
COPY public.division_footfall (id, earning_year, uts_iw, uts_ow, prs_iw, prs_ow, total_iw, total_ow, prs_daily_avg, uts_prs_daily_avg, station_code, division_code) FROM '$$PATH$$/5077.dat';

--
-- Data for Name: division_goods_commodity_outward; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_goods_commodity_outward (id, earning_year, rakes, wagon, weight, freight, commodity, division_code) FROM stdin;
\.
COPY public.division_goods_commodity_outward (id, earning_year, rakes, wagon, weight, freight, commodity, division_code) FROM '$$PATH$$/5069.dat';

--
-- Data for Name: division_goods_depowise_inward_traffic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_goods_depowise_inward_traffic (id, earning_year, rakes, wagon, weight, station_code, division_code) FROM stdin;
\.
COPY public.division_goods_depowise_inward_traffic (id, earning_year, rakes, wagon, weight, station_code, division_code) FROM '$$PATH$$/5079.dat';

--
-- Data for Name: division_goods_depowise_yearly_earning; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_goods_depowise_yearly_earning (id, earning_year, rakes, wagon, weight, freight, station_code, division_code) FROM stdin;
\.
COPY public.division_goods_depowise_yearly_earning (id, earning_year, rakes, wagon, weight, freight, station_code, division_code) FROM '$$PATH$$/5071.dat';

--
-- Data for Name: division_goods_monthwise_inward; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_goods_monthwise_inward (id, earning_month, rakes, wagon, weight, division_code) FROM stdin;
\.
COPY public.division_goods_monthwise_inward (id, earning_month, rakes, wagon, weight, division_code) FROM '$$PATH$$/5067.dat';

--
-- Data for Name: division_goods_monthwise_outward; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_goods_monthwise_outward (id, earning_month, rakes, wagon, weight, freight, division_code) FROM stdin;
\.
COPY public.division_goods_monthwise_outward (id, earning_month, rakes, wagon, weight, freight, division_code) FROM '$$PATH$$/5065.dat';

--
-- Data for Name: division_parcel_earning_monthwise; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_parcel_earning_monthwise (id, earning_year, item, packages, weight, revenue, division_code) FROM stdin;
\.
COPY public.division_parcel_earning_monthwise (id, earning_year, item, packages, weight, revenue, division_code) FROM '$$PATH$$/5081.dat';

--
-- Data for Name: division_parcel_earning_monthwise_comparative_lugg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_parcel_earning_monthwise_comparative_lugg (id, earning_month, packages, weight, revenue, division_code) FROM stdin;
\.
COPY public.division_parcel_earning_monthwise_comparative_lugg (id, earning_month, packages, weight, revenue, division_code) FROM '$$PATH$$/5083.dat';

--
-- Data for Name: division_target; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_target (earning_id, earning_month, uts_sub_urban_pass, non_sub_pass, total_pass, freight, other_coaching, total, sundry, gross_total, sub_passengers, non_sub_passengers, total_passengers, division_code, tc_cases, tc_amt, parcel_earning) FROM stdin;
\.
COPY public.division_target (earning_id, earning_month, uts_sub_urban_pass, non_sub_pass, total_pass, freight, other_coaching, total, sundry, gross_total, sub_passengers, non_sub_passengers, total_passengers, division_code, tc_cases, tc_amt, parcel_earning) FROM '$$PATH$$/5062.dat';

--
-- Data for Name: division_tc_monthwise_cases_earnings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_tc_monthwise_cases_earnings (id, earning_month, cases, amount, cases_target, amount_target, division_code) FROM stdin;
\.
COPY public.division_tc_monthwise_cases_earnings (id, earning_month, cases, amount, cases_target, amount_target, division_code) FROM '$$PATH$$/5073.dat';

--
-- Data for Name: division_tc_statement_of_earnings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division_tc_statement_of_earnings (id, earning_month, pwt_cases, pwt_amt, irregular_cases, irregular_amt, ubl_cases, ubl_amt, division_code) FROM stdin;
\.
COPY public.division_tc_statement_of_earnings (id, earning_month, pwt_cases, pwt_amt, irregular_cases, irregular_amt, ubl_cases, ubl_amt, division_code) FROM '$$PATH$$/5075.dat';

--
-- Data for Name: station; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.station (station_code, station_name, division_code, siding_flag, sdg_serving_stn, category, state, km_from_csmt, numerical_code, name_of_mp, name_of_mla) FROM stdin;
\.
COPY public.station (station_code, station_name, division_code, siding_flag, sdg_serving_stn, category, state, km_from_csmt, numerical_code, name_of_mp, name_of_mla) FROM '$$PATH$$/5059.dat';

--
-- Name: division_earnings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_earnings_id_seq', 22, true);


--
-- Name: division_footfall_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_footfall_id_seq', 1, false);


--
-- Name: division_goods_commodity_outward_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_goods_commodity_outward_id_seq', 73, true);


--
-- Name: division_goods_depowise_inward_traffic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_goods_depowise_inward_traffic_id_seq', 1, false);


--
-- Name: division_goods_depowise_yearly_earning_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_goods_depowise_yearly_earning_id_seq', 42, true);


--
-- Name: division_goods_monthwise_inward_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_goods_monthwise_inward_id_seq', 1, false);


--
-- Name: division_goods_monthwise_outward_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_goods_monthwise_outward_id_seq', 22, true);


--
-- Name: division_parcel_earning_monthwise_comparative_lugg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_parcel_earning_monthwise_comparative_lugg_id_seq', 1, false);


--
-- Name: division_parcel_earning_monthwise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_parcel_earning_monthwise_id_seq', 1, false);


--
-- Name: division_target_earning_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_target_earning_id_seq', 1, false);


--
-- Name: division_tc_monthwise_cases_earnings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_tc_monthwise_cases_earnings_id_seq', 2, true);


--
-- Name: division_tc_statement_of_earnings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_tc_statement_of_earnings_id_seq', 1, false);


--
-- Name: division division_division_code_division_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_division_code_division_name_key UNIQUE (division_code, division_name);


--
-- Name: division division_division_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_division_name_key UNIQUE (division_name);


--
-- Name: division_earnings division_earnings_division_code_earning_month_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_division_code_earning_month_key UNIQUE (division_code, earning_month);


--
-- Name: division_earnings division_earnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_pkey PRIMARY KEY (id);


--
-- Name: division_footfall division_footfall_division_code_station_code_earning_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_division_code_station_code_earning_year_key UNIQUE (division_code, station_code, earning_year);


--
-- Name: division_footfall division_footfall_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_pkey PRIMARY KEY (id);


--
-- Name: division_goods_commodity_outward division_goods_commodity_outw_division_code_earning_year_co_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outw_division_code_earning_year_co_key UNIQUE (division_code, earning_year, commodity);


--
-- Name: division_goods_commodity_outward division_goods_commodity_outward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outward_pkey PRIMARY KEY (id);


--
-- Name: division_goods_depowise_inward_traffic division_goods_depowise_inwar_division_code_earning_year_st_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inwar_division_code_earning_year_st_key UNIQUE (division_code, earning_year, station_code);


--
-- Name: division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_pkey PRIMARY KEY (id);


--
-- Name: division_goods_depowise_yearly_earning division_goods_depowise_yearl_division_code_earning_year_st_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearl_division_code_earning_year_st_key UNIQUE (division_code, earning_year, station_code);


--
-- Name: division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_pkey PRIMARY KEY (id);


--
-- Name: division_goods_monthwise_inward division_goods_monthwise_inward_division_code_earning_month_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_division_code_earning_month_key UNIQUE (division_code, earning_month);


--
-- Name: division_goods_monthwise_inward division_goods_monthwise_inward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_pkey PRIMARY KEY (id);


--
-- Name: division_goods_monthwise_outward division_goods_monthwise_outwar_division_code_earning_month_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outwar_division_code_earning_month_key UNIQUE (division_code, earning_month);


--
-- Name: division_goods_monthwise_outward division_goods_monthwise_outward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outward_pkey PRIMARY KEY (id);


--
-- Name: division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwi_division_code_earning_month_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwi_division_code_earning_month_key UNIQUE (division_code, earning_month);


--
-- Name: division_parcel_earning_monthwise division_parcel_earning_monthwis_division_code_earning_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwis_division_code_earning_year_key UNIQUE (division_code, earning_year);


--
-- Name: division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwise_comparative_lugg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwise_comparative_lugg_pkey PRIMARY KEY (id);


--
-- Name: division_parcel_earning_monthwise division_parcel_earning_monthwise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwise_pkey PRIMARY KEY (id);


--
-- Name: division division_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_pkey PRIMARY KEY (division_code);


--
-- Name: division_target division_target_division_code_earning_month_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_division_code_earning_month_key UNIQUE (division_code, earning_month);


--
-- Name: division_target division_target_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_pkey PRIMARY KEY (earning_id);


--
-- Name: division_tc_monthwise_cases_earnings division_tc_monthwise_cases_ear_division_code_earning_month_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_ear_division_code_earning_month_key UNIQUE (division_code, earning_month);


--
-- Name: division_tc_monthwise_cases_earnings division_tc_monthwise_cases_earnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_earnings_pkey PRIMARY KEY (id);


--
-- Name: division_tc_statement_of_earnings division_tc_statement_of_earnin_division_code_earning_month_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnin_division_code_earning_month_key UNIQUE (division_code, earning_month);


--
-- Name: division_tc_statement_of_earnings division_tc_statement_of_earnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnings_pkey PRIMARY KEY (id);


--
-- Name: station station_division_code_station_code_station_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_division_code_station_code_station_name_key UNIQUE (division_code, station_code, station_name);


--
-- Name: station station_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_code);


--
-- Name: division_earnings division_earnings_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_footfall division_footfall_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_footfall division_footfall_station_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);


--
-- Name: division_goods_commodity_outward division_goods_commodity_outward_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_station_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);


--
-- Name: division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_station_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);


--
-- Name: division_goods_monthwise_inward division_goods_monthwise_inward_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_goods_monthwise_outward division_goods_monthwise_outward_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwise_comparativ_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwise_comparativ_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_parcel_earning_monthwise division_parcel_earning_monthwise_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwise_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_target division_target_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_tc_monthwise_cases_earnings division_tc_monthwise_cases_earnings_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: division_tc_statement_of_earnings division_tc_statement_of_earnings_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- Name: station station_division_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               