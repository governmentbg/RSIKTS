using System;
using System.IO;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace DataAccess.Migrations
{
    public partial class Initial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "votingregister");

            migrationBuilder.Sql("ALTER DATABASE votingregister CHARACTER SET utf8 COLLATE utf8_unicode_ci");

            migrationBuilder.CreateTable(
                name: "aspnetroles",
                schema: "votingregister",
                columns: table => new
                {
                    Id = table.Column<string>( maxLength: 128, nullable: false),
                    Name = table.Column<string>( maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>( maxLength: 128, nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "longtext", nullable: true),
                    Discriminator = table.Column<string>( maxLength: 128, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aspnetroles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "n_lica",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(7)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Vid_id = table.Column<int>(type: "int(1)", nullable: true),
                    EGN = table.Column<string>( maxLength: 128, nullable: false),
                    IM1 = table.Column<string>( maxLength: 128, nullable: true),
                    IM2 = table.Column<string>( maxLength: 128, nullable: true),
                    IM3 = table.Column<string>( maxLength: 128, nullable: true),
                    Obra = table.Column<string>( maxLength: 16, nullable: true),
                    SpeС = table.Column<string>( maxLength: 16, nullable: true),
                    TEL = table.Column<string>( maxLength: 14, nullable: true),
                    PAS1 = table.Column<string>( maxLength: 1, nullable: true),
                    PAS2 = table.Column<string>( maxLength: 10, nullable: true),
                    PAS3 = table.Column<DateTime>(nullable: true),
                    PAS4 = table.Column<string>( maxLength: 2, nullable: true),
                    NAZ = table.Column<string>( maxLength: 2, nullable: true, defaultValueSql: "'BG'"),
                    OBL = table.Column<string>( maxLength: 3, nullable: true),
                    OBS = table.Column<string>( maxLength: 5, nullable: true),
                    RAJ = table.Column<string>( maxLength: 2, nullable: true),
                    NAS = table.Column<string>( maxLength: 5, nullable: true),
                    UL = table.Column<string>( maxLength: 5, nullable: true),
                    NOM = table.Column<string>( maxLength: 6, nullable: true),
                    JK_KV = table.Column<string>( maxLength: 2, nullable: true),
                    BLOK = table.Column<string>( maxLength: 5, nullable: true),
                    VH = table.Column<string>( maxLength: 2, nullable: true),
                    ET = table.Column<string>( maxLength: 2, nullable: true),
                    AP = table.Column<string>( maxLength: 3, nullable: true),
                    PK = table.Column<string>( maxLength: 4, nullable: true),
                    impstatus = table.Column<int>(type: "int(11)", nullable: true),
                    impmessage = table.Column<string>( maxLength: 100, nullable: true),
                    USER = table.Column<string>( maxLength: 128, nullable: true),
                    KOGA = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_lica", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "n_lica_import",
                schema: "votingregister",
                columns: table => new
                {
                    id = table.Column<int>(type: "int(11)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    egn = table.Column<string>( maxLength: 10, nullable: false),
                    im1 = table.Column<string>( maxLength: 50, nullable: false),
                    im2 = table.Column<string>( maxLength: 50, nullable: false),
                    im3 = table.Column<string>( maxLength: 50, nullable: false),
                    SIK = table.Column<string>( maxLength: 3, nullable: false),
                    Rolja = table.Column<string>( maxLength: 50, nullable: false),
                    Obra = table.Column<string>( maxLength: 50, nullable: true),
                    Spec = table.Column<string>( maxLength: 50, nullable: true),
                    Tel = table.Column<string>( maxLength: 50, nullable: true),
                    status = table.Column<int>(type: "int(11)", nullable: false),
                    opisanie = table.Column<string>( maxLength: 100, nullable: true),
                    user = table.Column<string>( maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_lica_import", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "n_list_codetables",
                schema: "votingregister",
                columns: table => new
                {
                    NKODE = table.Column<int>(type: "int(4)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    NIME = table.Column<string>( maxLength: 30, nullable: true),
                    Status = table.Column<int>(type: "int(1)", nullable: false, defaultValueSql: "1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_list_codetables", x => x.NKODE);
                });

            migrationBuilder.CreateTable(
                name: "n_log",
                schema: "votingregister",
                columns: table => new
                {
                    Id_LOG = table.Column<int>(type: "int(11)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    User = table.Column<string>( maxLength: 30, nullable: false),
                    Koga = table.Column<DateTime>(nullable: false),
                    ACTION = table.Column<int>(type: "int(11)", nullable: false),
                    Kod_Obrabotka = table.Column<string>( maxLength: 4, nullable: false),
                    Ime_Obrabotka = table.Column<string>( maxLength: 250, nullable: false),
                    AAA = table.Column<int>(type: "int(1)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_log", x => x.Id_LOG);
                });

            migrationBuilder.CreateTable(
                name: "n_nomenclatures",
                schema: "votingregister",
                columns: table => new
                {
                    id = table.Column<int>(type: "int(11)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    description = table.Column<string>( maxLength: 50, nullable: true),
                    table = table.Column<string>( maxLength: 50, nullable: true),
                    status = table.Column<short>(type: "smallint(1)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_nomenclatures", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "n_statistics",
                schema: "votingregister",
                columns: table => new
                {
                    id = table.Column<int>(type: "int(11)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    shortdescription = table.Column<string>( maxLength: 50, nullable: true),
                    longdescription = table.Column<string>( maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_statistics", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "n_top_dancoef",
                schema: "votingregister",
                columns: table => new
                {
                    ID_Coef = table.Column<int>(type: "int(6)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    IZB_ALLIAS = table.Column<string>( maxLength: 6, nullable: false),
                    Nred = table.Column<string>( maxLength: 2, nullable: false),
                    Fieldl_name_OLD = table.Column<string>( maxLength: 10, nullable: true),
                    Tekst = table.Column<string>( maxLength: 60, nullable: true),
                    Coef_stoinost = table.Column<decimal>(type: "decimal(6,4)", nullable: true),
                    Field_name_NEW = table.Column<string>( maxLength: 10, nullable: true),
                    Status_coef = table.Column<int>(type: "int(1)", nullable: true, defaultValueSql: "0")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_top_dancoef", x => x.ID_Coef);
                });

            migrationBuilder.CreateTable(
                name: "n_top_main",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(6)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    IZB_ALIAS = table.Column<string>( maxLength: 6, nullable: true, defaultValueSql: "NULL"),
                    Description = table.Column<string>( maxLength: 40, nullable: true),
                    DATE1TUR = table.Column<DateTime>(nullable: true),
                    DATE2TUR = table.Column<DateTime>(nullable: true),
                    Status_parameters = table.Column<int>(type: "int(1)", nullable: true, defaultValueSql: "1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_top_main", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "n_top_parameters",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(6)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    IZB_ALIAS = table.Column<string>( maxLength: 6, nullable: false, defaultValueSql: "'MI2019'"),
                    KOD = table.Column<string>( maxLength: 2, nullable: false),
                    Description = table.Column<string>( maxLength: 40, nullable: true),
                    Znachenie = table.Column<string>( maxLength: 40, nullable: true),
                    Status_parameters = table.Column<int>(type: "int(1)", nullable: true, defaultValueSql: "1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_top_parameters", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "n_top_partkvoti",
                schema: "votingregister",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int(6)", nullable: false),
                    Izb_Alias = table.Column<string>( maxLength: 6, nullable: false),
                    Izb_rajon = table.Column<string>( maxLength: 2, nullable: true),
                    TOA = table.Column<string>( maxLength: 2, nullable: true),
                    Status_kvoti = table.Column<int>(type: "int(1)", nullable: true),
                    USER = table.Column<string>( maxLength: 20, nullable: true),
                    code_wnsila = table.Column<string>( maxLength: 2, nullable: true),
                    SIK_Clenove = table.Column<int>(type: "int(4)", nullable: true),
                    SIK_HEADS = table.Column<int>(type: "int(4)", nullable: true),
                    KOGA = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_top_partkvoti", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "normi_operacii",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(7)", nullable: false),
                    Izb_allias = table.Column<string>( maxLength: 6, nullable: true),
                    Tur = table.Column<int>(type: "int(1)", nullable: true),
                    Vid_codetable = table.Column<string>(type: "char(1)", nullable: true, defaultValueSql: "3"),
                    Vid_operacia = table.Column<string>( maxLength: 3, nullable: true),
                    Pari = table.Column<decimal>(type: "decimal(6,2)", nullable: true),
                    Status = table.Column<int>(type: "int(1)", nullable: true),
                    User = table.Column<string>( maxLength: 128, nullable: true),
                    Koga = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_normi_operacii", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "normi_priznaci",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(7)", nullable: false),
                    Izb_allias = table.Column<string>( maxLength: 6, nullable: true),
                    Tur = table.Column<int>(type: "int(1)", nullable: true),
                    Vid_codetable = table.Column<string>(type: "char(1)", nullable: true, defaultValueSql: "2"),
                    Vid_priznak = table.Column<string>( maxLength: 3, nullable: true),
                    Pari = table.Column<decimal>(type: "decimal(6,2)", nullable: true),
                    Status = table.Column<int>(type: "int(1)", nullable: true),
                    User = table.Column<string>( maxLength: 128, nullable: true),
                    Koga = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_normi_priznaci", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "normi_roli",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(7)", nullable: false),
                    Izb_allias = table.Column<string>( maxLength: 6, nullable: true),
                    Tur = table.Column<int>(type: "int(1)", nullable: true),
                    Vid_codetable = table.Column<string>(type: "char(1)", nullable: true, defaultValueSql: "1"),
                    Vid_sekcia = table.Column<string>( maxLength: 3, nullable: true),
                    Vid_codetale_2 = table.Column<string>(type: "char(1)", nullable: true, defaultValueSql: "4"),
                    Vid_rolia = table.Column<string>( maxLength: 3, nullable: true),
                    Pari = table.Column<decimal>(type: "decimal(6,2)", nullable: true),
                    Status = table.Column<int>(type: "int(1)", nullable: true),
                    User = table.Column<string>( maxLength: 128, nullable: true),
                    Koga = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_normi_roli", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "sys_tables",
                schema: "votingregister",
                columns: table => new
                {
                    id = table.Column<int>(type: "int(11)", nullable: false),
                    name = table.Column<string>( maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_sys_tables", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "wnasm",
                schema: "votingregister",
                columns: table => new
                {
                    nkod = table.Column<string>( maxLength: 5, nullable: false),
                    nime = table.Column<string>( maxLength: 25, nullable: true),
                    Kmetstvo = table.Column<string>( maxLength: 8, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnasm", x => x.nkod);
                });

            migrationBuilder.CreateTable(
                name: "wndocs",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    NIME = table.Column<string>( maxLength: 40, nullable: true),
                    Status_ndocs = table.Column<sbyte>(type: "tinyint(1)", nullable: true, defaultValueSql: "1"),
                    Izb_Alias = table.Column<string>( maxLength: 6, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wndocs", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wnjk_kv",
                schema: "votingregister",
                columns: table => new
                {
                    nkod = table.Column<string>( maxLength: 5, nullable: false),
                    nime = table.Column<string>( maxLength: 30, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnjk_kv", x => x.nkod);
                });

            migrationBuilder.CreateTable(
                name: "wnkmetstva",
                schema: "votingregister",
                columns: table => new
                {
                    nkod = table.Column<string>( maxLength: 10, nullable: false),
                    nime = table.Column<string>( maxLength: 40, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnkmetstva", x => x.nkod);
                });

            migrationBuilder.CreateTable(
                name: "wnmaks",
                schema: "votingregister",
                columns: table => new
                {
                    ID_shablon = table.Column<int>(type: "int(5)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Izb_Alias = table.Column<string>( maxLength: 6, nullable: true, defaultValueSql: "'MI2019'"),
                    NKOD = table.Column<string>( maxLength: 10, nullable: true),
                    NIME = table.Column<string>( maxLength: 40, nullable: true),
                    Status_sh = table.Column<sbyte>(type: "tinyint(1)", nullable: true, defaultValueSql: "0")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnmaks", x => x.ID_shablon);
                });

            migrationBuilder.CreateTable(
                name: "wnnaz",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    NIME = table.Column<string>( maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnnaz", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wnnru",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    NIME = table.Column<string>( maxLength: 30, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnnru", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wnobl",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 3, nullable: false),
                    NIME = table.Column<string>( maxLength: 30, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnobl", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wnobs",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 5, nullable: false),
                    NIME = table.Column<string>( maxLength: 28, nullable: true),
                    ekatte = table.Column<string>( maxLength: 5, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnobs", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wnsila",
                schema: "votingregister",
                columns: table => new
                {
                    ID_Party = table.Column<int>(type: "int(5)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    IZB_ALIAS = table.Column<string>( maxLength: 6, nullable: false, defaultValueSql: "0"),
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    Short_name = table.Column<string>( maxLength: 15, nullable: true),
                    NIME = table.Column<string>( maxLength: 40, nullable: true),
                    Legal_Kod = table.Column<string>( maxLength: 3, nullable: true),
                    Status_Partii = table.Column<int>(type: "int(1)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnsila", x => x.ID_Party);
                });

            migrationBuilder.CreateTable(
                name: "wnspec",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    NIME = table.Column<string>( maxLength: 16, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnspec", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wnszem",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    NIME = table.Column<string>( maxLength: 16, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnszem", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wntoa",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    NIME = table.Column<string>( maxLength: 16, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wntoa", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wntoa_izbraion",
                schema: "votingregister",
                columns: table => new
                {
                    NKOD = table.Column<string>( maxLength: 2, nullable: false),
                    NIME = table.Column<string>( maxLength: 16, nullable: true),
                    IZB_R = table.Column<string>( maxLength: 2, nullable: true),
                    BROI_SIK = table.Column<int>(type: "int(11)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wntoa_izbraion", x => x.NKOD);
                });

            migrationBuilder.CreateTable(
                name: "wnuli",
                schema: "votingregister",
                columns: table => new
                {
                    nkod = table.Column<string>( maxLength: 5, nullable: false),
                    wnasm_nkod = table.Column<string>( maxLength: 5, nullable: true),
                    wnuli_nkod = table.Column<string>( maxLength: 5, nullable: true),
                    nime = table.Column<string>( maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_wnuli", x => x.nkod);
                });

            migrationBuilder.CreateTable(
                name: "aspnetroleclaims",
                schema: "votingregister",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int(11)", nullable: false),
                    RoleId = table.Column<string>( maxLength: 128, nullable: false),
                    ClaimType = table.Column<string>(type: "longtext", nullable: true),
                    ClaimValue = table.Column<string>(type: "longtext", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aspnetroleclaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalSchema: "votingregister",
                        principalTable: "aspnetroles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "n_list_codepositions",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(5)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    PKODE = table.Column<int>(type: "int(4)", nullable: false, defaultValueSql: "0"),
                    IZB_ALLIAS = table.Column<string>( maxLength: 6, nullable: false),
                    NKODE = table.Column<int>(type: "int(3)", nullable: false),
                    NIME = table.Column<string>( maxLength: 30, nullable: true),
                    Status = table.Column<int>(type: "int(1)", nullable: true, defaultValueSql: "1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_list_codepositions", x => x.ID);
                    table.ForeignKey(
                        name: "FK_CODEPOS_CODETABL",
                        column: x => x.PKODE,
                        principalSchema: "votingregister",
                        principalTable: "n_list_codetables",
                        principalColumn: "NKODE",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "aspnetusers",
                schema: "votingregister",
                columns: table => new
                {
                    Id = table.Column<string>( maxLength: 128, nullable: false),
                    UserName = table.Column<string>( maxLength: 256, nullable: true),
                    NormalizedUserName = table.Column<string>( maxLength: 128, nullable: true),
                    Email = table.Column<string>( maxLength: 256, nullable: true),
                    NormalizedEmail = table.Column<string>( maxLength: 256, nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "bit(1)", nullable: false),
                    PasswordHash = table.Column<string>(type: "longtext", nullable: true),
                    SecurityStamp = table.Column<string>(type: "longtext", nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "longtext", nullable: true),
                    PhoneNumber = table.Column<string>(type: "longtext", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "bit(1)", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "bit(1)", nullable: false),
                    LockoutEnd = table.Column<DateTime>(type: "datetime(6)", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "bit(1)", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "int(11)", nullable: false),
                    Discriminator = table.Column<string>(type: "longtext", nullable: true),
                    Administrative_Rajon = table.Column<string>( maxLength: 2, nullable: true),
                    Ot_Partiq = table.Column<int>(type: "int(5)", nullable: true),
                    Names = table.Column<string>( maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aspnetusers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_aspnetusers_wntoa_RajonNkod",
                        column: x => x.Administrative_Rajon,
                        principalSchema: "votingregister",
                        principalTable: "wntoa",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_aspnetusers_sila_PartiqIdParty",
                        column: x => x.Ot_Partiq,
                        principalSchema: "votingregister",
                        principalTable: "wnsila",
                        principalColumn: "ID_Party",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "n_lica_izbori",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(7)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    ID_Lice = table.Column<int>(type: "int(7)", nullable: false),
                    Izb_Alias = table.Column<string>( maxLength: 6, nullable: true, defaultValueSql: "'MI2019'"),
                    Tur = table.Column<int>(type: "int(1)", nullable: true),
                    TOA = table.Column<string>( maxLength: 2, nullable: true),
                    Id_Sik = table.Column<int>(type: "int(10)", nullable: true),
                    id_sila = table.Column<int>(type: "int(11)", nullable: true),
                    Re = table.Column<string>( maxLength: 40, nullable: true),
                    Code_rolia = table.Column<string>( maxLength: 3, nullable: false),
                    Ime_rolia = table.Column<string>( maxLength: 30, nullable: true),
                    USER = table.Column<string>( maxLength: 128, nullable: true),
                    KOGA = table.Column<DateTime>(nullable: true),
                    hasmaxincome = table.Column<int>(type: "int(1) unsigned zerofill", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_lica_izbori", x => x.ID);
                    table.ForeignKey(
                        name: "n_lica_izbori_ibfk_1",
                        column: x => x.ID_Lice,
                        principalSchema: "votingregister",
                        principalTable: "n_lica",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_lica_izbori_wnsila",
                        column: x => x.id_sila,
                        principalSchema: "votingregister",
                        principalTable: "wnsila",
                        principalColumn: "ID_Party",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_n_lica_izbori_wntoa",
                        column: x => x.TOA,
                        principalSchema: "votingregister",
                        principalTable: "wntoa",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "siks",
                schema: "votingregister",
                columns: table => new
                {
                    Id_sek = table.Column<int>(type: "int(10)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Izb_Alias = table.Column<string>( maxLength: 6, nullable: false),
                    TUR = table.Column<int>(type: "int(1)", nullable: true),
                    Izb_rajon = table.Column<string>( maxLength: 2, nullable: false),
                    TOA = table.Column<string>( maxLength: 2, nullable: false),
                    AA_BB_CC = table.Column<string>( maxLength: 6, nullable: false),
                    Sik = table.Column<string>( maxLength: 3, nullable: false),
                    Status_Sekcia = table.Column<int>(type: "int(1)", nullable: false),
                    Obl = table.Column<string>( maxLength: 3, nullable: true),
                    Obs = table.Column<string>( maxLength: 5, nullable: true),
                    NAS = table.Column<string>( maxLength: 5, nullable: true),
                    Kme = table.Column<string>( maxLength: 7, nullable: true, defaultValueSql: "'НЕ'"),
                    JK_KV = table.Column<string>( maxLength: 2, nullable: true),
                    UL = table.Column<string>( maxLength: 5, nullable: true),
                    Nom = table.Column<string>( maxLength: 5, nullable: true),
                    BLok = table.Column<string>( maxLength: 5, nullable: true),
                    Tel = table.Column<string>( maxLength: 10, nullable: true),
                    ADR_IME = table.Column<string>( maxLength: 60, nullable: true),
                    USER = table.Column<string>( maxLength: 128, nullable: true),
                    Koga = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_siks", x => x.Id_sek);
                    table.ForeignKey(
                        name: "siks_ibfk_3",
                        column: x => x.NAS,
                        principalSchema: "votingregister",
                        principalTable: "wnasm",
                        principalColumn: "nkod",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "siks_ibfk_1",
                        column: x => x.Obl,
                        principalSchema: "votingregister",
                        principalTable: "wnobl",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "siks_ibfk_2",
                        column: x => x.Obs,
                        principalSchema: "votingregister",
                        principalTable: "wnobs",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_SIKS_WNTOA",
                        column: x => x.TOA,
                        principalSchema: "votingregister",
                        principalTable: "wntoa",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "n_toa_main",
                schema: "votingregister",
                columns: table => new
                {
                    Nrec = table.Column<int>(type: "int(11)", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    IZB_ALIAS = table.Column<string>( maxLength: 6, nullable: true, defaultValueSql: "'MI2019'"),
                    TOA = table.Column<string>( maxLength: 2, nullable: true),
                    Tur = table.Column<sbyte>(type: "tinyint(1)", nullable: false, defaultValueSql: "1"),
                    Status_Master = table.Column<int>(type: "int(1)", nullable: true, defaultValueSql: "1"),
                    IME = table.Column<string>( maxLength: 30, nullable: true),
                    TEL = table.Column<string>( maxLength: 10, nullable: true),
                    Tel1 = table.Column<string>( maxLength: 10, nullable: true),
                    Izr = table.Column<string>( maxLength: 15, nullable: true),
                    OBL = table.Column<string>( maxLength: 3, nullable: true),
                    OBS = table.Column<string>( maxLength: 5, nullable: true),
                    RAJ = table.Column<string>( maxLength: 2, nullable: true),
                    NAS = table.Column<string>( maxLength: 5, nullable: true),
                    UL = table.Column<string>( maxLength: 5, nullable: true),
                    NOM = table.Column<string>( maxLength: 4, nullable: true),
                    JK_KV = table.Column<string>( maxLength: 2, nullable: true),
                    BLOK = table.Column<string>( maxLength: 5, nullable: true),
                    VH = table.Column<string>( maxLength: 2, nullable: true),
                    ET = table.Column<string>( maxLength: 2, nullable: true),
                    AP = table.Column<string>( maxLength: 3, nullable: true),
                    PK = table.Column<string>( maxLength: 4, nullable: true),
                    EPOD = table.Column<string>( maxLength: 30, nullable: true),
                    IPOD = table.Column<string>( maxLength: 20, nullable: true),
                    Pred = table.Column<string>( maxLength: 20, nullable: true),
                    Sekr = table.Column<string>( maxLength: 20, nullable: true),
                    Nsik = table.Column<int>(type: "int(11)", nullable: true),
                    Pris = table.Column<string>( maxLength: 10, nullable: true),
                    R1 = table.Column<string>( maxLength: 20, nullable: true),
                    R2 = table.Column<string>( maxLength: 20, nullable: true),
                    ANO = table.Column<int>(type: "int(11)", nullable: true),
                    Bul = table.Column<string>( maxLength: 13, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_toa_main", x => x.Nrec);
                    table.ForeignKey(
                        name: "n_toa_main_ibfk_8",
                        column: x => x.JK_KV,
                        principalSchema: "votingregister",
                        principalTable: "wnjk_kv",
                        principalColumn: "nkod",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "n_toa_main_ibfk_3",
                        column: x => x.NAS,
                        principalSchema: "votingregister",
                        principalTable: "wnasm",
                        principalColumn: "nkod",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "n_toa_main_ibfk_5",
                        column: x => x.OBL,
                        principalSchema: "votingregister",
                        principalTable: "wnobl",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "n_toa_main_ibfk_6",
                        column: x => x.OBS,
                        principalSchema: "votingregister",
                        principalTable: "wnobs",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "n_toa_main_ibfk_1",
                        column: x => x.RAJ,
                        principalSchema: "votingregister",
                        principalTable: "wntoa",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_MASTER_WNTOA",
                        column: x => x.TOA,
                        principalSchema: "votingregister",
                        principalTable: "wntoa",
                        principalColumn: "NKOD",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "n_toa_main_ibfk_7",
                        column: x => x.UL,
                        principalSchema: "votingregister",
                        principalTable: "wnuli",
                        principalColumn: "nkod",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "aspnetuserclaims",
                schema: "votingregister",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int(11)", nullable: false),
                    UserId = table.Column<string>( maxLength: 128, nullable: false),
                    ClaimType = table.Column<string>(type: "longtext", nullable: true),
                    ClaimValue = table.Column<string>(type: "longtext", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aspnetuserclaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUserClaims_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalSchema: "votingregister",
                        principalTable: "aspnetusers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "aspnetuserlogins",
                schema: "votingregister",
                columns: table => new
                {
                    LoginProvider = table.Column<string>( maxLength: 128, nullable: false),
                    ProviderKey = table.Column<string>( maxLength: 128, nullable: false),
                    ProviderDisplayName = table.Column<string>(type: "longtext", nullable: true),
                    UserId = table.Column<string>( maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aspnetuserlogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_AspNetUserLogins_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalSchema: "votingregister",
                        principalTable: "aspnetusers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "aspnetuserroles",
                schema: "votingregister",
                columns: table => new
                {
                    UserId = table.Column<string>( maxLength: 128, nullable: false),
                    RoleId = table.Column<string>( maxLength: 128, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aspnetuserroles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalSchema: "votingregister",
                        principalTable: "aspnetroles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalSchema: "votingregister",
                        principalTable: "aspnetusers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "aspnetusertokens",
                schema: "votingregister",
                columns: table => new
                {
                    UserId = table.Column<string>( maxLength: 128, nullable: false),
                    LoginProvider = table.Column<string>( maxLength: 128, nullable: false),
                    Name = table.Column<string>( maxLength: 128, nullable: false),
                    Value = table.Column<string>(type: "longtext", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aspnetusertokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_AspNetUserTokens_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalSchema: "votingregister",
                        principalTable: "aspnetusers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "n_lica_dopylnenie",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(7)", nullable: false),
                    Id_Lice = table.Column<int>(type: "int(7)", nullable: true),
                    Vid_codeT = table.Column<string>(type: "char(1)", nullable: true, defaultValueSql: "3"),
                    Code_operacia = table.Column<string>( maxLength: 3, nullable: true),
                    Status = table.Column<int>(type: "int(1)", nullable: true, defaultValueSql: "1"),
                    User = table.Column<string>( maxLength: 128, nullable: true),
                    Koga = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_lica_dopylnenie", x => x.ID);
                    table.ForeignKey(
                        name: "FK_nlicadop_nlica",
                        column: x => x.Id_Lice,
                        principalSchema: "votingregister",
                        principalTable: "n_lica_izbori",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "n_lice_pari_zanap",
                schema: "votingregister",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int(8)", nullable: false),
                    ID_Lice = table.Column<int>(type: "int(8)", nullable: false),
                    Code_dancoef = table.Column<string>( maxLength: 2, nullable: true),
                    Pari = table.Column<decimal>(type: "decimal(10,4)", nullable: true),
                    Koga = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_lice_pari_zanap", x => x.Id);
                    table.ForeignKey(
                        name: "FK_nlicaparizanap_nlica",
                        column: x => x.ID_Lice,
                        principalSchema: "votingregister",
                        principalTable: "n_lica_izbori",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "n_lice_pari_zaplashtane",
                schema: "votingregister",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int(8)", nullable: false),
                    ID_Lice = table.Column<int>(type: "int(8)", nullable: false),
                    Code_Table = table.Column<string>(type: "char(1)", nullable: true),
                    Code_possition = table.Column<string>( maxLength: 3, nullable: true),
                    Pari = table.Column<decimal>(type: "decimal(10,4)", nullable: true),
                    Koga = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_n_lice_pari_zaplashtane", x => x.Id);
                    table.ForeignKey(
                        name: "FK_nlicaparizaplashtane_nlica",
                        column: x => x.ID_Lice,
                        principalSchema: "votingregister",
                        principalTable: "n_lica_izbori",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "siks_vidove",
                schema: "votingregister",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int(7)", nullable: false),
                    IZB_allias = table.Column<string>( maxLength: 6, nullable: false),
                    Tur = table.Column<int>(type: "int(1)", nullable: false),
                    Id_Sik = table.Column<int>(type: "int(11)", nullable: false),
                    Codetable = table.Column<string>(type: "char(1)", nullable: true),
                    Codeposition = table.Column<string>( maxLength: 3, nullable: true),
                    Status = table.Column<int>(type: "int(1)", nullable: true, defaultValueSql: "1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_siks_vidove", x => x.ID);
                    table.ForeignKey(
                        name: "FK_SIKS_VIDOVE_SIKS",
                        column: x => x.Id_Sik,
                        principalSchema: "votingregister",
                        principalTable: "siks",
                        principalColumn: "Id_sek",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AspNetRoleClaims_RoleId",
                schema: "votingregister",
                table: "aspnetroleclaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                schema: "votingregister",
                table: "aspnetroles",
                column: "NormalizedName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserClaims_UserId",
                schema: "votingregister",
                table: "aspnetuserclaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserLogins_UserId",
                schema: "votingregister",
                table: "aspnetuserlogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserRoles_RoleId",
                schema: "votingregister",
                table: "aspnetuserroles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "FK_aspnetusers_wntoa_RajonNkod",
                schema: "votingregister",
                table: "aspnetusers",
                column: "Administrative_Rajon");

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                schema: "votingregister",
                table: "aspnetusers",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                schema: "votingregister",
                table: "aspnetusers",
                column: "NormalizedUserName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "FK_aspnetusers_sila_PartiqIdParty",
                schema: "votingregister",
                table: "aspnetusers",
                column: "Ot_Partiq");

            migrationBuilder.CreateIndex(
                name: "JK_KV",
                schema: "votingregister",
                table: "n_lica",
                column: "JK_KV");

            migrationBuilder.CreateIndex(
                name: "NAS",
                schema: "votingregister",
                table: "n_lica",
                column: "NAS");

            migrationBuilder.CreateIndex(
                name: "OBL",
                schema: "votingregister",
                table: "n_lica",
                column: "OBL");

            migrationBuilder.CreateIndex(
                name: "OBS",
                schema: "votingregister",
                table: "n_lica",
                column: "OBS");

            migrationBuilder.CreateIndex(
                name: "RAJ",
                schema: "votingregister",
                table: "n_lica",
                column: "RAJ");

            migrationBuilder.CreateIndex(
                name: "UL",
                schema: "votingregister",
                table: "n_lica",
                column: "UL");

            migrationBuilder.CreateIndex(
                name: "FK_nlicadop_nlica",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                column: "Id_Lice");

            migrationBuilder.CreateIndex(
                name: "n_lica_izbori_ibfk_1",
                schema: "votingregister",
                table: "n_lica_izbori",
                column: "ID_Lice");

            migrationBuilder.CreateIndex(
                name: "FK_lica_izbori_siks_1",
                schema: "votingregister",
                table: "n_lica_izbori",
                column: "Id_Sik");

            migrationBuilder.CreateIndex(
                name: "FK_lica_izbori_wnsila",
                schema: "votingregister",
                table: "n_lica_izbori",
                column: "id_sila");

            migrationBuilder.CreateIndex(
                name: "FK_n_lica_izbori_wntoa",
                schema: "votingregister",
                table: "n_lica_izbori",
                column: "TOA");

            migrationBuilder.CreateIndex(
                name: "FK_nlicaparizanap_nlica",
                schema: "votingregister",
                table: "n_lice_pari_zanap",
                column: "ID_Lice");

            migrationBuilder.CreateIndex(
                name: "FK_nlicaparizaplashtane_nlica",
                schema: "votingregister",
                table: "n_lice_pari_zaplashtane",
                column: "ID_Lice");

            migrationBuilder.CreateIndex(
                name: "FK_CODEPOS_CODETABL",
                schema: "votingregister",
                table: "n_list_codepositions",
                column: "PKODE");

            migrationBuilder.CreateIndex(
                name: "JK_KV",
                schema: "votingregister",
                table: "n_toa_main",
                column: "JK_KV");

            migrationBuilder.CreateIndex(
                name: "NAS",
                schema: "votingregister",
                table: "n_toa_main",
                column: "NAS");

            migrationBuilder.CreateIndex(
                name: "OBL",
                schema: "votingregister",
                table: "n_toa_main",
                column: "OBL");

            migrationBuilder.CreateIndex(
                name: "OBS",
                schema: "votingregister",
                table: "n_toa_main",
                column: "OBS");

            migrationBuilder.CreateIndex(
                name: "RAJ",
                schema: "votingregister",
                table: "n_toa_main",
                column: "RAJ");

            migrationBuilder.CreateIndex(
                name: "FK_MASTER_WNTOA",
                schema: "votingregister",
                table: "n_toa_main",
                column: "TOA");

            migrationBuilder.CreateIndex(
                name: "UL",
                schema: "votingregister",
                table: "n_toa_main",
                column: "UL");

            migrationBuilder.CreateIndex(
                name: "JK_KV",
                schema: "votingregister",
                table: "siks",
                column: "JK_KV");

            migrationBuilder.CreateIndex(
                name: "Kme",
                schema: "votingregister",
                table: "siks",
                column: "Kme");

            migrationBuilder.CreateIndex(
                name: "NAS",
                schema: "votingregister",
                table: "siks",
                column: "NAS");

            migrationBuilder.CreateIndex(
                name: "Obl",
                schema: "votingregister",
                table: "siks",
                column: "Obl");

            migrationBuilder.CreateIndex(
                name: "Obs",
                schema: "votingregister",
                table: "siks",
                column: "Obs");

            migrationBuilder.CreateIndex(
                name: "FK_SIKS_WNTOA",
                schema: "votingregister",
                table: "siks",
                column: "TOA");

            migrationBuilder.CreateIndex(
                name: "UL",
                schema: "votingregister",
                table: "siks",
                column: "UL");

            migrationBuilder.CreateIndex(
                name: "FK_SIKS_VIDOVE_SIKS",
                schema: "votingregister",
                table: "siks_vidove",
                column: "Id_Sik");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {         
            migrationBuilder.DropTable(
                name: "aspnetroleclaims",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "aspnetuserclaims",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "aspnetuserlogins",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "aspnetuserroles",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "aspnetusertokens",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_lica_dopylnenie",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_lica_import",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_lice_pari_zanap",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_lice_pari_zaplashtane",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_list_codepositions",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_log",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_nomenclatures",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_statistics",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_toa_main",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_top_dancoef",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_top_main",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_top_parameters",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_top_partkvoti",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "normi_operacii",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "normi_priznaci",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "normi_roli",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "siks_vidove",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "sys_tables",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wndocs",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnkmetstva",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnmaks",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnnaz",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnnru",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnspec",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnszem",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wntoa_izbraion",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "aspnetroles",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "aspnetusers",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_lica_izbori",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_list_codetables",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnjk_kv",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnuli",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "siks",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "n_lica",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnsila",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnasm",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnobl",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wnobs",
                schema: "votingregister");

            migrationBuilder.DropTable(
                name: "wntoa",
                schema: "votingregister");
        }
    }
}
