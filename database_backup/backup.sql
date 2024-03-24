PGDMP                       |            railway_dashboard    16.2    16.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    railway_dashboard    DATABASE     �   CREATE DATABASE railway_dashboard WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 !   DROP DATABASE railway_dashboard;
                postgres    false                        2615    16399 	   divisions    SCHEMA        CREATE SCHEMA divisions;
    DROP SCHEMA divisions;
                postgres    false            �            1259    16479    division    TABLE       CREATE TABLE public.division (
    division_code character varying(5) NOT NULL,
    division_name character varying(30) NOT NULL,
    railway_code character varying(5) DEFAULT 'CR'::character varying NOT NULL,
    location character varying,
    contact_info character varying
);
    DROP TABLE public.division;
       public         heap    postgres    false            �            1259    16508    division_earnings    TABLE       CREATE TABLE public.division_earnings (
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
       public         heap    postgres    false            �            1259    16566    division_earnings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.division_earnings_id_seq;
       public          postgres    false    218            �           0    0    division_earnings_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.division_earnings_id_seq OWNED BY public.division_earnings.id;
          public          postgres    false    221            �            1259    16721    division_footfall    TABLE     �  CREATE TABLE public.division_footfall (
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
       public         heap    postgres    false            �            1259    16720    division_footfall_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_footfall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.division_footfall_id_seq;
       public          postgres    false    235            �           0    0    division_footfall_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.division_footfall_id_seq OWNED BY public.division_footfall.id;
          public          postgres    false    234            �            1259    16625     division_goods_commodity_outward    TABLE     �  CREATE TABLE public.division_goods_commodity_outward (
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
       public         heap    postgres    false            �            1259    16624 '   division_goods_commodity_outward_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_commodity_outward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.division_goods_commodity_outward_id_seq;
       public          postgres    false    227            �           0    0 '   division_goods_commodity_outward_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.division_goods_commodity_outward_id_seq OWNED BY public.division_goods_commodity_outward.id;
          public          postgres    false    226            �            1259    16748 &   division_goods_depowise_inward_traffic    TABLE     U  CREATE TABLE public.division_goods_depowise_inward_traffic (
    id integer NOT NULL,
    earning_year date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    station_code character varying(5),
    division_code character varying(5)
);
 :   DROP TABLE public.division_goods_depowise_inward_traffic;
       public         heap    postgres    false            �            1259    16747 -   division_goods_depowise_inward_traffic_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_depowise_inward_traffic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.division_goods_depowise_inward_traffic_id_seq;
       public          postgres    false    237            �           0    0 -   division_goods_depowise_inward_traffic_id_seq    SEQUENCE OWNED BY        ALTER SEQUENCE public.division_goods_depowise_inward_traffic_id_seq OWNED BY public.division_goods_depowise_inward_traffic.id;
          public          postgres    false    236            �            1259    16647 &   division_goods_depowise_yearly_earning    TABLE     �  CREATE TABLE public.division_goods_depowise_yearly_earning (
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
       public         heap    postgres    false            �            1259    16646 -   division_goods_depowise_yearly_earning_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_depowise_yearly_earning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.division_goods_depowise_yearly_earning_id_seq;
       public          postgres    false    229            �           0    0 -   division_goods_depowise_yearly_earning_id_seq    SEQUENCE OWNED BY        ALTER SEQUENCE public.division_goods_depowise_yearly_earning_id_seq OWNED BY public.division_goods_depowise_yearly_earning.id;
          public          postgres    false    228            �            1259    16603    division_goods_monthwise_inward    TABLE     (  CREATE TABLE public.division_goods_monthwise_inward (
    id integer NOT NULL,
    earning_month date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 3   DROP TABLE public.division_goods_monthwise_inward;
       public         heap    postgres    false            �            1259    16602 &   division_goods_monthwise_inward_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_monthwise_inward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.division_goods_monthwise_inward_id_seq;
       public          postgres    false    225            �           0    0 &   division_goods_monthwise_inward_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.division_goods_monthwise_inward_id_seq OWNED BY public.division_goods_monthwise_inward.id;
          public          postgres    false    224            �            1259    16579     division_goods_monthwise_outward    TABLE     Z  CREATE TABLE public.division_goods_monthwise_outward (
    id integer NOT NULL,
    earning_month date NOT NULL,
    rakes double precision DEFAULT 0 NOT NULL,
    wagon double precision DEFAULT 0 NOT NULL,
    weight double precision DEFAULT 0 NOT NULL,
    freight double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 4   DROP TABLE public.division_goods_monthwise_outward;
       public         heap    postgres    false            �            1259    16578 '   division_goods_monthwise_outward_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_goods_monthwise_outward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.division_goods_monthwise_outward_id_seq;
       public          postgres    false    223            �           0    0 '   division_goods_monthwise_outward_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.division_goods_monthwise_outward_id_seq OWNED BY public.division_goods_monthwise_outward.id;
          public          postgres    false    222            �            1259    16770 !   division_parcel_earning_monthwise    TABLE     F  CREATE TABLE public.division_parcel_earning_monthwise (
    id integer NOT NULL,
    earning_year date NOT NULL,
    item character varying(30) DEFAULT 0 NOT NULL,
    packages integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    revenue integer DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 5   DROP TABLE public.division_parcel_earning_monthwise;
       public         heap    postgres    false            �            1259    16790 2   division_parcel_earning_monthwise_comparative_lugg    TABLE     %  CREATE TABLE public.division_parcel_earning_monthwise_comparative_lugg (
    id integer NOT NULL,
    earning_month date NOT NULL,
    packages integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    revenue integer DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 F   DROP TABLE public.division_parcel_earning_monthwise_comparative_lugg;
       public         heap    postgres    false            �            1259    16789 9   division_parcel_earning_monthwise_comparative_lugg_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 P   DROP SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq;
       public          postgres    false    241            �           0    0 9   division_parcel_earning_monthwise_comparative_lugg_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.division_parcel_earning_monthwise_comparative_lugg_id_seq OWNED BY public.division_parcel_earning_monthwise_comparative_lugg.id;
          public          postgres    false    240            �            1259    16769 (   division_parcel_earning_monthwise_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_parcel_earning_monthwise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.division_parcel_earning_monthwise_id_seq;
       public          postgres    false    239            �           0    0 (   division_parcel_earning_monthwise_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.division_parcel_earning_monthwise_id_seq OWNED BY public.division_parcel_earning_monthwise.id;
          public          postgres    false    238            �            1259    16531    division_target    TABLE     s  CREATE TABLE public.division_target (
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
       public         heap    postgres    false            �           0    0    COLUMN division_target.tc_cases    COMMENT     U   COMMENT ON COLUMN public.division_target.tc_cases IS 'tecket checking target cases';
          public          postgres    false    220            �           0    0    COLUMN division_target.tc_amt    COMMENT     T   COMMENT ON COLUMN public.division_target.tc_amt IS 'ticket checking target amount';
          public          postgres    false    220            �           0    0 %   COLUMN division_target.parcel_earning    COMMENT     T   COMMENT ON COLUMN public.division_target.parcel_earning IS 'parcel earning target';
          public          postgres    false    220            �            1259    16530    division_target_earning_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_target_earning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.division_target_earning_id_seq;
       public          postgres    false    220            �           0    0    division_target_earning_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.division_target_earning_id_seq OWNED BY public.division_target.earning_id;
          public          postgres    false    219            �            1259    16681 $   division_tc_monthwise_cases_earnings    TABLE     Y  CREATE TABLE public.division_tc_monthwise_cases_earnings (
    id integer NOT NULL,
    earning_month date NOT NULL,
    cases integer DEFAULT 0 NOT NULL,
    amount double precision DEFAULT 0 NOT NULL,
    cases_target integer DEFAULT 0 NOT NULL,
    amount_target double precision DEFAULT 0 NOT NULL,
    division_code character varying(5)
);
 8   DROP TABLE public.division_tc_monthwise_cases_earnings;
       public         heap    postgres    false            �            1259    16680 +   division_tc_monthwise_cases_earnings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq;
       public          postgres    false    231            �           0    0 +   division_tc_monthwise_cases_earnings_id_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public.division_tc_monthwise_cases_earnings_id_seq OWNED BY public.division_tc_monthwise_cases_earnings.id;
          public          postgres    false    230            �            1259    16699 !   division_tc_statement_of_earnings    TABLE     �  CREATE TABLE public.division_tc_statement_of_earnings (
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
       public         heap    postgres    false            �            1259    16698 (   division_tc_statement_of_earnings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.division_tc_statement_of_earnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.division_tc_statement_of_earnings_id_seq;
       public          postgres    false    233            �           0    0 (   division_tc_statement_of_earnings_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.division_tc_statement_of_earnings_id_seq OWNED BY public.division_tc_statement_of_earnings.id;
          public          postgres    false    232            �            1259    16491    station    TABLE     L  CREATE TABLE public.station (
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
       public         heap    postgres    false            �           0    0    COLUMN station.category    COMMENT     L   COMMENT ON COLUMN public.station.category IS 'station category by earning';
          public          postgres    false    217            �           0    0    COLUMN station.km_from_csmt    COMMENT     K   COMMENT ON COLUMN public.station.km_from_csmt IS 'kilometer from csmt/Hq';
          public          postgres    false    217            �           0    0    COLUMN station.name_of_mla    COMMENT     L   COMMENT ON COLUMN public.station.name_of_mla IS 'mla name of station area';
          public          postgres    false    217            �           2604    16567    division_earnings id    DEFAULT     |   ALTER TABLE ONLY public.division_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_earnings_id_seq'::regclass);
 C   ALTER TABLE public.division_earnings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    218            �           2604    16724    division_footfall id    DEFAULT     |   ALTER TABLE ONLY public.division_footfall ALTER COLUMN id SET DEFAULT nextval('public.division_footfall_id_seq'::regclass);
 C   ALTER TABLE public.division_footfall ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    16628 #   division_goods_commodity_outward id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_commodity_outward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_commodity_outward_id_seq'::regclass);
 R   ALTER TABLE public.division_goods_commodity_outward ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            �           2604    16751 )   division_goods_depowise_inward_traffic id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic ALTER COLUMN id SET DEFAULT nextval('public.division_goods_depowise_inward_traffic_id_seq'::regclass);
 X   ALTER TABLE public.division_goods_depowise_inward_traffic ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236    237            �           2604    16650 )   division_goods_depowise_yearly_earning id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning ALTER COLUMN id SET DEFAULT nextval('public.division_goods_depowise_yearly_earning_id_seq'::regclass);
 X   ALTER TABLE public.division_goods_depowise_yearly_earning ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16606 "   division_goods_monthwise_inward id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_monthwise_inward_id_seq'::regclass);
 Q   ALTER TABLE public.division_goods_monthwise_inward ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    16582 #   division_goods_monthwise_outward id    DEFAULT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward ALTER COLUMN id SET DEFAULT nextval('public.division_goods_monthwise_outward_id_seq'::regclass);
 R   ALTER TABLE public.division_goods_monthwise_outward ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    16773 $   division_parcel_earning_monthwise id    DEFAULT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise ALTER COLUMN id SET DEFAULT nextval('public.division_parcel_earning_monthwise_id_seq'::regclass);
 S   ALTER TABLE public.division_parcel_earning_monthwise ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239            �           2604    16793 5   division_parcel_earning_monthwise_comparative_lugg id    DEFAULT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg ALTER COLUMN id SET DEFAULT nextval('public.division_parcel_earning_monthwise_comparative_lugg_id_seq'::regclass);
 d   ALTER TABLE public.division_parcel_earning_monthwise_comparative_lugg ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    241    241            �           2604    16534    division_target earning_id    DEFAULT     �   ALTER TABLE ONLY public.division_target ALTER COLUMN earning_id SET DEFAULT nextval('public.division_target_earning_id_seq'::regclass);
 I   ALTER TABLE public.division_target ALTER COLUMN earning_id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    16684 '   division_tc_monthwise_cases_earnings id    DEFAULT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_tc_monthwise_cases_earnings_id_seq'::regclass);
 V   ALTER TABLE public.division_tc_monthwise_cases_earnings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    16702 $   division_tc_statement_of_earnings id    DEFAULT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings ALTER COLUMN id SET DEFAULT nextval('public.division_tc_statement_of_earnings_id_seq'::regclass);
 S   ALTER TABLE public.division_tc_statement_of_earnings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233            �          0    16479    division 
   TABLE DATA           f   COPY public.division (division_code, division_name, railway_code, location, contact_info) FROM stdin;
    public          postgres    false    216   v�       �          0    16508    division_earnings 
   TABLE DATA           �   COPY public.division_earnings (earning_month, uts_sub_urban_pass, uts_non_sub_pass, prs_pass, total_pass, freight, other_coaching, total, sundry, gross_total, division_code, total_passengers, sub_passengers, non_sub_passengers, id) FROM stdin;
    public          postgres    false    218   ��       �          0    16721    division_footfall 
   TABLE DATA           �   COPY public.division_footfall (id, earning_year, uts_iw, uts_ow, prs_iw, prs_ow, total_iw, total_ow, prs_daily_avg, uts_prs_daily_avg, station_code, division_code) FROM stdin;
    public          postgres    false    235   9�       �          0    16625     division_goods_commodity_outward 
   TABLE DATA           �   COPY public.division_goods_commodity_outward (id, earning_year, rakes, wagon, weight, freight, commodity, division_code) FROM stdin;
    public          postgres    false    227   V�       �          0    16748 &   division_goods_depowise_inward_traffic 
   TABLE DATA           �   COPY public.division_goods_depowise_inward_traffic (id, earning_year, rakes, wagon, weight, station_code, division_code) FROM stdin;
    public          postgres    false    237   <�       �          0    16647 &   division_goods_depowise_yearly_earning 
   TABLE DATA           �   COPY public.division_goods_depowise_yearly_earning (id, earning_year, rakes, wagon, weight, freight, station_code, division_code) FROM stdin;
    public          postgres    false    229   Y�       �          0    16603    division_goods_monthwise_inward 
   TABLE DATA           q   COPY public.division_goods_monthwise_inward (id, earning_month, rakes, wagon, weight, division_code) FROM stdin;
    public          postgres    false    225    �       �          0    16579     division_goods_monthwise_outward 
   TABLE DATA           {   COPY public.division_goods_monthwise_outward (id, earning_month, rakes, wagon, weight, freight, division_code) FROM stdin;
    public          postgres    false    223   �       �          0    16770 !   division_parcel_earning_monthwise 
   TABLE DATA           }   COPY public.division_parcel_earning_monthwise (id, earning_year, item, packages, weight, revenue, division_code) FROM stdin;
    public          postgres    false    239   ��       �          0    16790 2   division_parcel_earning_monthwise_comparative_lugg 
   TABLE DATA           �   COPY public.division_parcel_earning_monthwise_comparative_lugg (id, earning_month, packages, weight, revenue, division_code) FROM stdin;
    public          postgres    false    241   ��       �          0    16531    division_target 
   TABLE DATA             COPY public.division_target (earning_id, earning_month, uts_sub_urban_pass, non_sub_pass, total_pass, freight, other_coaching, total, sundry, gross_total, sub_passengers, non_sub_passengers, total_passengers, division_code, tc_cases, tc_amt, parcel_earning) FROM stdin;
    public          postgres    false    220   ��       �          0    16681 $   division_tc_monthwise_cases_earnings 
   TABLE DATA           �   COPY public.division_tc_monthwise_cases_earnings (id, earning_month, cases, amount, cases_target, amount_target, division_code) FROM stdin;
    public          postgres    false    231   ��       �          0    16699 !   division_tc_statement_of_earnings 
   TABLE DATA           �   COPY public.division_tc_statement_of_earnings (id, earning_month, pwt_cases, pwt_amt, irregular_cases, irregular_amt, ubl_cases, ubl_amt, division_code) FROM stdin;
    public          postgres    false    233   =�       �          0    16491    station 
   TABLE DATA           �   COPY public.station (station_code, station_name, division_code, siding_flag, sdg_serving_stn, category, state, km_from_csmt, numerical_code, name_of_mp, name_of_mla) FROM stdin;
    public          postgres    false    217   ��       �           0    0    division_earnings_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.division_earnings_id_seq', 22, true);
          public          postgres    false    221            �           0    0    division_footfall_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.division_footfall_id_seq', 1, false);
          public          postgres    false    234            �           0    0 '   division_goods_commodity_outward_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.division_goods_commodity_outward_id_seq', 73, true);
          public          postgres    false    226            �           0    0 -   division_goods_depowise_inward_traffic_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.division_goods_depowise_inward_traffic_id_seq', 1, false);
          public          postgres    false    236            �           0    0 -   division_goods_depowise_yearly_earning_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.division_goods_depowise_yearly_earning_id_seq', 42, true);
          public          postgres    false    228            �           0    0 &   division_goods_monthwise_inward_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.division_goods_monthwise_inward_id_seq', 1, false);
          public          postgres    false    224            �           0    0 '   division_goods_monthwise_outward_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.division_goods_monthwise_outward_id_seq', 22, true);
          public          postgres    false    222            �           0    0 9   division_parcel_earning_monthwise_comparative_lugg_id_seq    SEQUENCE SET     h   SELECT pg_catalog.setval('public.division_parcel_earning_monthwise_comparative_lugg_id_seq', 1, false);
          public          postgres    false    240            �           0    0 (   division_parcel_earning_monthwise_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.division_parcel_earning_monthwise_id_seq', 1, false);
          public          postgres    false    238            �           0    0    division_target_earning_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.division_target_earning_id_seq', 1, false);
          public          postgres    false    219            �           0    0 +   division_tc_monthwise_cases_earnings_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.division_tc_monthwise_cases_earnings_id_seq', 2, true);
          public          postgres    false    230            �           0    0 (   division_tc_statement_of_earnings_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.division_tc_statement_of_earnings_id_seq', 1, false);
          public          postgres    false    232            �           2606    16490 1   division division_division_code_division_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_division_code_division_name_key UNIQUE (division_code, division_name);
 [   ALTER TABLE ONLY public.division DROP CONSTRAINT division_division_code_division_name_key;
       public            postgres    false    216    216            �           2606    16488 #   division division_division_name_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_division_name_key UNIQUE (division_name);
 M   ALTER TABLE ONLY public.division DROP CONSTRAINT division_division_name_key;
       public            postgres    false    216            �           2606    16557 C   division_earnings division_earnings_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_division_code_earning_month_key UNIQUE (division_code, earning_month);
 m   ALTER TABLE ONLY public.division_earnings DROP CONSTRAINT division_earnings_division_code_earning_month_key;
       public            postgres    false    218    218            �           2606    16569 (   division_earnings division_earnings_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.division_earnings DROP CONSTRAINT division_earnings_pkey;
       public            postgres    false    218                       2606    16736 O   division_footfall division_footfall_division_code_station_code_earning_year_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_division_code_station_code_earning_year_key UNIQUE (division_code, station_code, earning_year);
 y   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_division_code_station_code_earning_year_key;
       public            postgres    false    235    235    235                       2606    16734 (   division_footfall division_footfall_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_pkey;
       public            postgres    false    235                       2606    16640 `   division_goods_commodity_outward division_goods_commodity_outw_division_code_earning_year_co_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outw_division_code_earning_year_co_key UNIQUE (division_code, earning_year, commodity);
 �   ALTER TABLE ONLY public.division_goods_commodity_outward DROP CONSTRAINT division_goods_commodity_outw_division_code_earning_year_co_key;
       public            postgres    false    227    227    227                       2606    16638 F   division_goods_commodity_outward division_goods_commodity_outward_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outward_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.division_goods_commodity_outward DROP CONSTRAINT division_goods_commodity_outward_pkey;
       public            postgres    false    227                       2606    16758 f   division_goods_depowise_inward_traffic division_goods_depowise_inwar_division_code_earning_year_st_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inwar_division_code_earning_year_st_key UNIQUE (division_code, earning_year, station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inwar_division_code_earning_year_st_key;
       public            postgres    false    237    237    237                       2606    16756 R   division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inward_traffic_pkey;
       public            postgres    false    237                       2606    16662 f   division_goods_depowise_yearly_earning division_goods_depowise_yearl_division_code_earning_year_st_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearl_division_code_earning_year_st_key UNIQUE (division_code, earning_year, station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearl_division_code_earning_year_st_key;
       public            postgres    false    229    229    229            
           2606    16660 R   division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearly_earning_pkey;
       public            postgres    false    229                        2606    16618 _   division_goods_monthwise_inward division_goods_monthwise_inward_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_goods_monthwise_inward DROP CONSTRAINT division_goods_monthwise_inward_division_code_earning_month_key;
       public            postgres    false    225    225                       2606    16616 D   division_goods_monthwise_inward division_goods_monthwise_inward_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.division_goods_monthwise_inward DROP CONSTRAINT division_goods_monthwise_inward_pkey;
       public            postgres    false    225            �           2606    16596 `   division_goods_monthwise_outward division_goods_monthwise_outwar_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outwar_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_goods_monthwise_outward DROP CONSTRAINT division_goods_monthwise_outwar_division_code_earning_month_key;
       public            postgres    false    223    223            �           2606    16594 F   division_goods_monthwise_outward division_goods_monthwise_outward_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outward_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.division_goods_monthwise_outward DROP CONSTRAINT division_goods_monthwise_outward_pkey;
       public            postgres    false    223                        2606    16800 r   division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwi_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwi_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg DROP CONSTRAINT division_parcel_earning_monthwi_division_code_earning_month_key;
       public            postgres    false    241    241                       2606    16781 a   division_parcel_earning_monthwise division_parcel_earning_monthwis_division_code_earning_year_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwis_division_code_earning_year_key UNIQUE (division_code, earning_year);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise DROP CONSTRAINT division_parcel_earning_monthwis_division_code_earning_year_key;
       public            postgres    false    239    239            "           2606    16798 j   division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwise_comparative_lugg_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwise_comparative_lugg_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg DROP CONSTRAINT division_parcel_earning_monthwise_comparative_lugg_pkey;
       public            postgres    false    241                       2606    16779 H   division_parcel_earning_monthwise division_parcel_earning_monthwise_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwise_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.division_parcel_earning_monthwise DROP CONSTRAINT division_parcel_earning_monthwise_pkey;
       public            postgres    false    239            �           2606    16486    division division_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_pkey PRIMARY KEY (division_code);
 @   ALTER TABLE ONLY public.division DROP CONSTRAINT division_pkey;
       public            postgres    false    216            �           2606    16549 ?   division_target division_target_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_division_code_earning_month_key UNIQUE (division_code, earning_month);
 i   ALTER TABLE ONLY public.division_target DROP CONSTRAINT division_target_division_code_earning_month_key;
       public            postgres    false    220    220            �           2606    16547 $   division_target division_target_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_pkey PRIMARY KEY (earning_id);
 N   ALTER TABLE ONLY public.division_target DROP CONSTRAINT division_target_pkey;
       public            postgres    false    220                       2606    16692 d   division_tc_monthwise_cases_earnings division_tc_monthwise_cases_ear_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_ear_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings DROP CONSTRAINT division_tc_monthwise_cases_ear_division_code_earning_month_key;
       public            postgres    false    231    231                       2606    16690 N   division_tc_monthwise_cases_earnings division_tc_monthwise_cases_earnings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_earnings_pkey PRIMARY KEY (id);
 x   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings DROP CONSTRAINT division_tc_monthwise_cases_earnings_pkey;
       public            postgres    false    231                       2606    16712 a   division_tc_statement_of_earnings division_tc_statement_of_earnin_division_code_earning_month_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnin_division_code_earning_month_key UNIQUE (division_code, earning_month);
 �   ALTER TABLE ONLY public.division_tc_statement_of_earnings DROP CONSTRAINT division_tc_statement_of_earnin_division_code_earning_month_key;
       public            postgres    false    233    233                       2606    16710 H   division_tc_statement_of_earnings division_tc_statement_of_earnings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnings_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.division_tc_statement_of_earnings DROP CONSTRAINT division_tc_statement_of_earnings_pkey;
       public            postgres    false    233            �           2606    16501 ;   station station_division_code_station_code_station_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_division_code_station_code_station_name_key UNIQUE (division_code, station_code, station_name);
 e   ALTER TABLE ONLY public.station DROP CONSTRAINT station_division_code_station_code_station_name_key;
       public            postgres    false    217    217    217            �           2606    16497    station station_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_code);
 >   ALTER TABLE ONLY public.station DROP CONSTRAINT station_pkey;
       public            postgres    false    217            $           2606    16525 6   division_earnings division_earnings_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_earnings
    ADD CONSTRAINT division_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 `   ALTER TABLE ONLY public.division_earnings DROP CONSTRAINT division_earnings_division_code_fkey;
       public          postgres    false    216    218    4846            -           2606    16742 6   division_footfall division_footfall_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 `   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_division_code_fkey;
       public          postgres    false    4846    235    216            .           2606    16737 5   division_footfall division_footfall_station_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_footfall
    ADD CONSTRAINT division_footfall_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);
 _   ALTER TABLE ONLY public.division_footfall DROP CONSTRAINT division_footfall_station_code_fkey;
       public          postgres    false    217    4850    235            (           2606    16641 T   division_goods_commodity_outward division_goods_commodity_outward_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_commodity_outward
    ADD CONSTRAINT division_goods_commodity_outward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 ~   ALTER TABLE ONLY public.division_goods_commodity_outward DROP CONSTRAINT division_goods_commodity_outward_division_code_fkey;
       public          postgres    false    227    4846    216            /           2606    16764 `   division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inward_traffic_division_code_fkey;
       public          postgres    false    216    4846    237            0           2606    16759 _   division_goods_depowise_inward_traffic division_goods_depowise_inward_traffic_station_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic
    ADD CONSTRAINT division_goods_depowise_inward_traffic_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_inward_traffic DROP CONSTRAINT division_goods_depowise_inward_traffic_station_code_fkey;
       public          postgres    false    237    217    4850            )           2606    16668 `   division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearly_earning_division_code_fkey;
       public          postgres    false    216    229    4846            *           2606    16663 _   division_goods_depowise_yearly_earning division_goods_depowise_yearly_earning_station_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning
    ADD CONSTRAINT division_goods_depowise_yearly_earning_station_code_fkey FOREIGN KEY (station_code) REFERENCES public.station(station_code);
 �   ALTER TABLE ONLY public.division_goods_depowise_yearly_earning DROP CONSTRAINT division_goods_depowise_yearly_earning_station_code_fkey;
       public          postgres    false    217    229    4850            '           2606    16619 R   division_goods_monthwise_inward division_goods_monthwise_inward_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_inward
    ADD CONSTRAINT division_goods_monthwise_inward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 |   ALTER TABLE ONLY public.division_goods_monthwise_inward DROP CONSTRAINT division_goods_monthwise_inward_division_code_fkey;
       public          postgres    false    225    4846    216            &           2606    16597 T   division_goods_monthwise_outward division_goods_monthwise_outward_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_goods_monthwise_outward
    ADD CONSTRAINT division_goods_monthwise_outward_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 ~   ALTER TABLE ONLY public.division_goods_monthwise_outward DROP CONSTRAINT division_goods_monthwise_outward_division_code_fkey;
       public          postgres    false    216    223    4846            2           2606    16801 r   division_parcel_earning_monthwise_comparative_lugg division_parcel_earning_monthwise_comparativ_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg
    ADD CONSTRAINT division_parcel_earning_monthwise_comparativ_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise_comparative_lugg DROP CONSTRAINT division_parcel_earning_monthwise_comparativ_division_code_fkey;
       public          postgres    false    241    216    4846            1           2606    16782 V   division_parcel_earning_monthwise division_parcel_earning_monthwise_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_parcel_earning_monthwise
    ADD CONSTRAINT division_parcel_earning_monthwise_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_parcel_earning_monthwise DROP CONSTRAINT division_parcel_earning_monthwise_division_code_fkey;
       public          postgres    false    239    4846    216            %           2606    16550 2   division_target division_target_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_target
    ADD CONSTRAINT division_target_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 \   ALTER TABLE ONLY public.division_target DROP CONSTRAINT division_target_division_code_fkey;
       public          postgres    false    4846    216    220            +           2606    16693 \   division_tc_monthwise_cases_earnings division_tc_monthwise_cases_earnings_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings
    ADD CONSTRAINT division_tc_monthwise_cases_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_tc_monthwise_cases_earnings DROP CONSTRAINT division_tc_monthwise_cases_earnings_division_code_fkey;
       public          postgres    false    231    4846    216            ,           2606    16713 V   division_tc_statement_of_earnings division_tc_statement_of_earnings_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.division_tc_statement_of_earnings
    ADD CONSTRAINT division_tc_statement_of_earnings_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 �   ALTER TABLE ONLY public.division_tc_statement_of_earnings DROP CONSTRAINT division_tc_statement_of_earnings_division_code_fkey;
       public          postgres    false    4846    216    233            #           2606    16502 "   station station_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_division_code_fkey FOREIGN KEY (division_code) REFERENCES public.division(division_code);
 L   ALTER TABLE ONLY public.station DROP CONSTRAINT station_division_code_fkey;
       public          postgres    false    217    216    4846            �   @   x�+(�K� �A�>�ɉ%��y
���F�&�f\ťE���9�@Y��������%W� �Z�      �   c  x�EUK�,7[����c[�K�����!e�f1�����Q�4�3���1e��rj��q\���1RV�%up�졊6������*���#'�~��ׅ�&{g�-�5J��=�US��߸��]����, ��{����A� =}�/1R���gw�|ؘ�!ӆ�������� �g$���!�A��HQ,;�]bO	���a�7�V��eJ�@�r�<�[���9h?�F�-�8��Y Y>����.��]�M��ۊo(�1S
6ş��p�xib��P��M*t����RӠ���3��E�t*j@��=H{��\���g�J���P�]P?� �
ո�A٘-D ��ySPmeAW$u�s$7�@��S�~�B��a.:Ld�dsԃ�{z��+pi2n���2\�d)�f�.�l�[B�.h5�?��lcbw3F�L� -녬Uk�����1Z���7~5�$�����X�$N�=�d1���<�X��a��d_���pIj5`v��Q�I��(��v�þy�&���B6��~��[��<Ȣe�g�m�n��@1�����*o��o������i/gH�~/�V5{eQ��]U�O�7>�Wd�wװ�jSf���� ���s\� ���"�z۰�¾���i�p���9�&��U��E���wz?$+ GH�<��*c��y #f��]�LC\���Bg�0��<��)��޷�J�02���L�4h�۝��+Ȫ_�v����C��)ϫL�Y]h��	��4����a:�=��D����K/&���\��f�:������mdKv?��.����*�/�{/�z!>��ew��c�/�>�#�Y�z��I��^�^�Zx�}�����?a�_�      �      x������ � �      �   �  x�u�M��0���)|�	�GJZz�q�D��`�A�����e&r*��0`�D��
-�y���(a,e��"H	��K���t��,~���scܪ ���#Rx'7�P��Xx_�<�|m��NS�B�4B��.΃VNxI?Q��9��0�{��\�!�S���(�9}s�
�9�=��t�؜��.����.�.��	%n��NZ�OiGs���r�i����"G�/��v�IÂ9K��q����f���-�1��8|>��$�İixT�!����JѥS�J?`����|m��i'�Ѱ�CQ!YP
C����2�}lr����,��ڴӡ �C��}� _r�ef0%Bo�P�[S��.0Fb�d[�p�_�����!wK��ވ�h���!���]� %ǬC��c����:h8���h_^�r?�����V�Y�m���>Gv۵��k��]�+�;v�+�;v�+���n6��>:d      �      x������ � �      �   �  x�U�[N1E�ݽPٱ��{዇(P
j��s3L;�*�U�Ď�ɈS�w�w*d�$�TYk	jB����9=懶�X�V-Xkь$��}c3ɸ*������r��^��^%�(9�t�<��s����T��2��PI��EF2@ZAo����r��,SI_�������:���� �)W*������9PAQ�"������u�j�������JMnx�\.���uծEN�ݑvk�;lS�h����&�GSD�Wu�#��3h���=Uuj#)�d��m��n���h6��=��{��9�W]zྐྵ�6��ӳ ���{�M�Ɯ�� �L�9͑�q�+���Ws��	��g	\6s6�)d&k�٤�g�+�K��5x�M��u|Y����YN�ʊtB�X����n���]�      �      x������ � �      �   u  x�M�;��0�k�wC�Ö�2���m��CG
0U�i��PQ����͆���GN���������4����0���܅Yc��rx�.f�yc��<F@�k��Ec�`�B,5c�O/l5v,����.F,�)ly0��{�x���!���<;;�����ƴn&�\<��	�;�0��PyRB�g*����+=:��P���hsV58��/����
k�Zu��orf̎�ν��W0�H��Y'��tƈ�Y��`	�H�IN��jp��"gn�,��w�V�q�[նn��'�~}ĳ�;�϶����n���Y�yĆ�VԮ�[����̶8��t4ؽ�=���Z&L����O/����,���g������%éz      �      x������ � �      �      x������ � �      �     x�M�;�$1Cc�.#�k[w�t��&s���il�(��G�T�4e�/�/��4��E��L�Ռ�9ɼ�$E4�1���*�M�G3������nf�+k�������-!�kIl��'~��?� <�l{#��	�]'�nW`\�l�(g[N9�-J�
��$}�PPTR� �[@g	@�n0���% ģ� �����W@�$�)����Ǐ�z��(ʿH��_�D@�?�%����g�P���5/)v�Fn}\z^�,�HK��1�!��t|�z�SHU[�w��Ưؕ�g�y���+*�5Ȑ>[�'1K���*�a����v�F��{���x9x����'fQ�O
�!/ǃ{�yj���z�Up�lV��ׂc��¸�K����b��E4�:j����Q���ĳ���_�n&y\P� ����sw�;�QKG |�ѯ�;Z<���������&wZbc���J�k�t�G7�o�>|���G�f�#{t�����1X�����-��?�{�y3�-      �   <  x�]�;r�0�ھ�jx�6m&M���wǝ�I�~�A@� y l�|�? �߿����1��p[ &J�i0hnƑu�@�"���Oy����\��o���*�р����� ���jL�	l���*����H-x� �O�-�8�n�fȆ\�I�������0�jÝ� z�L�΂Y���p���eχ>Wi��l��r�u��H �Ao�S�wAs���v�]�' �-�[�H�;��!O:x@�^m�Ρ�$���r>�Vu��JC�Der�73�Ln�a;n�Ϋ�HA�@��=��q��?�f�       �   A  x�m�;��0�k�]�ç�6m�&��H�����OCG�|�&�,�����w,�-�D,�-CE��~��`�x�m�֪����;]�=���W��]!K=ɁB��6/�Ձt76�Mc%ᬫ�B[ ��ʄ������f��[�X��v�"-j�\�M���!+���é\���i��`+Z�NN�������rZtQ�ˌ{Qt����W����p��5�u�bSxe�j���-/w�����aSPڑ�J����4��E�u@<`���V���Ʈn�u�w�mZ�< ݡ�%q�hټ�Q�x�6��%�K�&�.v0b!������^·��Dj�d���K��ӱ�]/�x2�EA�ROq��
�e{�'8������Qs���tw��-���a7!=gM�x*�ܬl�:5i'�t�`xc�� Az�<<��̡�F���_�����Ʃ�䃕���%u��h;R��g��v-��
�d��89�
o�0�����Z��g��1i�������-_Wq��_Qu=#�F���s��5�����6{���?�g�g���������(U�*      �   �  x��T�n�0|V�B0��� ��h���a@_X���Ȳ@I	�������
�6|�#��C�(����x������L���� /��I^�����k�"�m�kŵ�:�^�1Q�0w�޺1��v�vF�
}"p�'�>�w��%x;Q�D�:؂�*���YX/k}�K�;0礲xt������
;�Q�&=�=RvӘTk�����qjl 7�����Wb���U�겑�!ĳ:-uI,3��Sa:z;:]�.��� �[D�\>��(7�~? �Wʈ�X�̮��2�`�:H%�iqÐGL<�lA�`#n�MI`؊���oK��P+7�(�,� ���lW�{�Xm}{�>�2�
^���WO�y�f�Bs��L���V�|������_@���y��N�a&�v����Վ$���9(��#�V�������/f���Z?     