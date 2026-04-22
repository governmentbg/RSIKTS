using System;
using System.ComponentModel.DataAnnotations.Schema;
using Common.ViewModels.User;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace DataAccess
{
    public partial class VotingRegisterContext : IdentityDbContext<SSOUserIdentity>
    {
        public VotingRegisterContext()
        {
        }

        public VotingRegisterContext(DbContextOptions<VotingRegisterContext> options)
            : base(options)
        {
        }

        public virtual DbSet<SysUsermain> SysUsermain { get; set; }
        public virtual DbSet<SysToaMain> SysToaMains { get; set; }
        public virtual DbSet<SysMain> SysMains { get; set; }
        public virtual DbSet<Aspnetroleclaims> Aspnetroleclaims { get; set; }
        public virtual DbSet<Aspnetroles> Aspnetroles { get; set; }
        public virtual DbSet<Aspnetuserclaims> Aspnetuserclaims { get; set; }
        public virtual DbSet<Aspnetuserlogins> Aspnetuserlogins { get; set; }
        public virtual DbSet<Aspnetuserroles> Aspnetuserroles { get; set; }
        public virtual DbSet<Aspnetusers> Aspnetusers { get; set; }
        public virtual DbSet<SSOUserIdentity> SSOUserIdentities { get; set; }
        public virtual DbSet<Aspnetusertokens> Aspnetusertokens { get; set; }
        public virtual DbSet<NLica> NLica { get; set; }
        public virtual DbSet<NLicaDopylnenie> NLicaDopylnenie { get; set; }
        public virtual DbSet<NLicaImport> NLicaImport { get; set; }
        public virtual DbSet<NLicaIzbori> NLicaIzbori { get; set; }
        public virtual DbSet<NLicePariZanap> NLicePariZanap { get; set; }
        public virtual DbSet<NLicePariZaplashtane> NLicePariZaplashtane { get; set; }
        public virtual DbSet<NListCodepositions> NListCodepositions { get; set; }
        public virtual DbSet<NListCodetables> NListCodetables { get; set; }
        public virtual DbSet<NLog> NLog { get; set; }
        public virtual DbSet<NNomenclatures> NNomenclatures { get; set; }
        public virtual DbSet<NStatistics> NStatistics { get; set; }
        public virtual DbSet<NToaMain> NToaMain { get; set; }
        public virtual DbSet<NTopDancoef> NTopDancoef { get; set; }
        public virtual DbSet<NTopMain> NTopMain { get; set; }
        public virtual DbSet<NTopParameters> NTopParameters { get; set; }
        public virtual DbSet<NTopPartkvoti> NTopPartkvoti { get; set; }
        public virtual DbSet<NormiOperacii> NormiOperacii { get; set; }
        public virtual DbSet<NormiPriznaci> NormiPriznaci { get; set; }
        public virtual DbSet<NormiRoli> NormiRoli { get; set; }
        public virtual DbSet<Siks> Siks { get; set; }
        public virtual DbSet<SiksVidove> SiksVidove { get; set; }
        public virtual DbSet<SysTables> SysTables { get; set; }
        public virtual DbSet<Wnasm> Wnasm { get; set; }
        public virtual DbSet<Wndocs> Wndocs { get; set; }
        public virtual DbSet<WnjkKv> WnjkKv { get; set; }
        public virtual DbSet<Wnkmetstva> Wnkmetstva { get; set; }
        public virtual DbSet<Wnmaks> Wnmaks { get; set; }
        public virtual DbSet<Wnnaz> Wnnaz { get; set; }
        public virtual DbSet<Wnnru> Wnnru { get; set; }
        public virtual DbSet<Wnobl> Wnobl { get; set; }
        public virtual DbSet<Wnobs> Wnobs { get; set; }
        public virtual DbSet<Wnsila> Wnsila { get; set; }
        public virtual DbSet<Wnspec> Wnspec { get; set; }
        public virtual DbSet<Wnszem> Wnszem { get; set; }
        public virtual DbSet<Wntoa> Wntoa { get; set; }
        public virtual DbSet<WntoaIzbraion> WntoaIzbraion { get; set; }
        public virtual DbSet<Wnuli> Wnuli { get; set; }
        public virtual DbSet<Wnizbraion> WnIzbRaion { get; set; }
        public virtual DbSet<NLicaZamestvane> NLicaZamestaveSet { get; set; }
        public virtual DbSet<NTopPartgrid> NTopPartgrids { get; set; }
        public virtual DbSet<Wntipizbori> WnTipIzbori { get; set; }

        //v.2
        public virtual DbSet<SiksPodvijni> SiksPodvizjni { get; set; }
        public virtual DbSet<SpisukSekciiGraniciSpravka> SpisukSekciiGraniciSpravkaSet { get; set; }
        public virtual DbSet<SpisukSpravkaRzi> SpisukSpravkaRziSet { get; set; }

        [NotMapped]
        public virtual DbSet<Spravka91> Spravka91Set { get; set; }
        [NotMapped]
        public virtual DbSet<Spravka93> SustoqnieNaRegistraciiteSpravkaSet { get; set; }
        [NotMapped]
        public virtual DbSet<Spravka23Set> ZamestvajiSpravka { get; set; }
        [NotMapped]
        public virtual DbSet<Spravka43Set> ReshetkaSpravkaSet{ get; set; }
        [NotMapped]
        public virtual DbSet<Spravka41Set> ZaetiPoziciiSet { get; set; }
        [NotMapped]
        public virtual DbSet<BroiSekciiSpravka> BroiSekciiSpravkaSet { get; set; }
        [NotMapped]
        public virtual DbSet<SpisukNaSekciiteSpravka> SpisukNaSekciiteSpravkaSet { get; set; }
        [NotMapped]
        public virtual DbSet<Spravka32> Spravka32Set{ get; set; }
        [NotMapped]
        public virtual DbSet<VedomostSpravka> VedomostSpravki { get; set; }
        [NotMapped]
        public virtual DbSet<Spravka211> Spravka211Set { get; set; }
        [NotMapped]
        public virtual DbSet<MorsStatistic> MorsStatistics { get; set; }
        [NotMapped]
        public virtual DbSet<MsbStatistic> MsbStatistics { get; set; }
        [NotMapped]
        public virtual DbSet<MsbdStatistic> MsbdStatistics { get; set; }
        [NotMapped]
        public virtual DbSet<MudoStatistic> MudoStatistics { get; set; }
        [NotMapped]
        public virtual DbSet<ReshetkaSumGrid> ReshetkaSumGrids { get; set; }
        [NotMapped]
        public virtual DbSet<ReshetkaDetails> ReshetkaDetailsSet { get; set; }
        [NotMapped]
        public virtual DbSet<Reshetka> ReshetkaSet { get; set; }
        [NotMapped]
        public virtual DbSet<KvotiForGrid> KvotiForGridSet { get; set; }
        [NotMapped]
        public virtual DbSet<IdReturnSet> IdReturnSet { get; set; }
        [NotMapped]
        public virtual DbSet<NapFileLine> NapFileLine { get; set; }
        [NotMapped]
        public virtual DbSet<LiceImpMessage> ImpMessageReturnSet { get; set; }
        [NotMapped]
        public virtual DbSet<LiceImpExcelMsg> ImpExcelMsgReturnSet { get; set; }
        [NotMapped]
        public virtual DbSet<LicaForGrid> LicaForGridSet { get; set; }
        [NotMapped]
        public virtual DbSet<LicaForWrongImport> LicaForWrongImports { get; set; }
        [NotMapped]
        public virtual DbSet<SikForGrid> SikForGridSet { get; set; }

        [NotMapped]
        public virtual DbSet<Spravka212> Spravka212Set { get; set; }

        [NotMapped]
        public virtual DbSet<NLica4Grid> NLica4Grid { get; set; }

//v.2
        [NotMapped]
        public virtual DbSet<PaymentsForGrid> PaymentsForGridSet { get; set; }
        
        [NotMapped]
        public virtual DbSet<IstoriaSik> IstoriaSikSet { get; set; }

        [NotMapped]
        public virtual DbSet<SpisykPodvizjniSekcii> SpisykPodvizjniSekciiSet { get; set; }

        [NotMapped]
        public virtual DbSet<SpravkaSekciiLica> SpravkaSekciiLica { get; set; }




        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseMySQL("server=localhost;uid=tbsoft2019;pwd=P@ssw0rd01;database=votingregister;TreatTinyAsBoolean=false");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.HasAnnotation("ProductVersion", "2.2.4-servicing-10062");

            modelBuilder.Entity<Aspnetroleclaims>(entity =>
            {
                entity.ToTable("aspnetroleclaims");

                entity.HasIndex(e => e.RoleId)
                    .HasName("IX_AspNetRoleClaims_RoleId");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever();

                entity.Property(e => e.ClaimType).HasColumnType("longtext");

                entity.Property(e => e.ClaimValue).HasColumnType("longtext");

                entity.Property(e => e.RoleId)
                    .IsRequired()
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.Aspnetroleclaims)
                    .HasForeignKey(d => d.RoleId)
                    .HasConstraintName("FK_AspNetRoleClaims_AspNetRoles_RoleId");
            });

            modelBuilder.Entity<SysUsermain>(entity =>
            {
                entity.ToTable("sys_usermain");
            });

            modelBuilder.Entity<NTopPartgrid>(entity =>
            {
                entity.ToTable("n_top_partgrid");
            });

            modelBuilder.Entity<NLicaZamestvane>(entity =>
            {
                entity.ToTable("n_lica_izbori_zamestvane");

                entity.Property(e => e.IdLiceNovo).HasColumnName("ID_Lice_novo");

                entity.Property(e => e.IdLiceStaro).HasColumnName("Id_Lice_staro");
            });

            modelBuilder.Entity<Aspnetroles>(entity =>
            {
                entity.ToTable("aspnetroles");

                entity.HasIndex(e => e.NormalizedName)
                    .HasName("RoleNameIndex")
                    .IsUnique();

                entity.Property(e => e.Id)
                    .HasMaxLength(128)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.ConcurrencyStamp).HasColumnType("longtext");

                entity.Property(e => e.Discriminator)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Name)
                    .HasMaxLength(256)
                    .IsUnicode(false);

                entity.Property(e => e.NormalizedName)
                    .HasMaxLength(128)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Aspnetuserclaims>(entity =>
            {
                entity.ToTable("aspnetuserclaims");

                entity.HasIndex(e => e.UserId)
                    .HasName("IX_AspNetUserClaims_UserId");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever();

                entity.Property(e => e.ClaimType).HasColumnType("longtext");

                entity.Property(e => e.ClaimValue).HasColumnType("longtext");

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Aspnetuserclaims)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_AspNetUserClaims_AspNetUsers_UserId");
            });

            modelBuilder.Entity<Aspnetuserlogins>(entity =>
            {
                entity.HasKey(e => new { e.LoginProvider, e.ProviderKey });

                entity.ToTable("aspnetuserlogins");

                entity.HasIndex(e => e.UserId)
                    .HasName("IX_AspNetUserLogins_UserId");

                entity.Property(e => e.LoginProvider)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.ProviderKey)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.ProviderDisplayName).HasColumnType("longtext");

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Aspnetuserlogins)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_AspNetUserLogins_AspNetUsers_UserId");
            });

            modelBuilder.Entity<Aspnetuserroles>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.RoleId });

                entity.ToTable("aspnetuserroles");

                entity.HasIndex(e => e.RoleId)
                    .HasName("IX_AspNetUserRoles_RoleId");

                entity.Property(e => e.UserId)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.RoleId)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.Aspnetuserroles)
                    .HasForeignKey(d => d.RoleId)
                    .HasConstraintName("FK_AspNetUserRoles_AspNetRoles_RoleId");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Aspnetuserroles)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_AspNetUserRoles_AspNetUsers_UserId");
            });

            modelBuilder.Entity<Aspnetusers>(entity =>
            {
                entity.ToTable("aspnetusers");

                entity.HasIndex(e => e.AdministrativeRajon)
                    .HasName("FK_aspnetusers_wntoa_RajonNkod");

                entity.HasIndex(e => e.NormalizedEmail)
                    .HasName("EmailIndex");

                entity.HasIndex(e => e.NormalizedUserName)
                    .HasName("UserNameIndex")
                    .IsUnique();

                entity.HasIndex(e => e.OtPartiq)
                    .HasName("FK_aspnetusers_sila_PartiqIdParty");

                entity.Property(e => e.Id)
                    .HasMaxLength(128)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.AccessFailedCount).HasColumnType("int(11)");

                entity.Property(e => e.AdministrativeRajon)
                    .HasColumnName("Administrative_Rajon")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.ConcurrencyStamp).HasColumnType("longtext");

                entity.Property(e => e.Discriminator).HasColumnType("longtext");

                entity.Property(e => e.Email)
                    .HasMaxLength(256)
                    .IsUnicode(false);

                entity.Property(e => e.EmailConfirmed).HasColumnType("bit(1)");

                entity.Property(e => e.LockoutEnabled).HasColumnType("bit(1)");

                entity.Property(e => e.LockoutEnd).HasColumnType("datetime(6)");

                entity.Property(e => e.Names)
                    .IsRequired()
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.NormalizedEmail)
                    .HasMaxLength(256)
                    .IsUnicode(false);

                entity.Property(e => e.NormalizedUserName)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.OtPartiq)
                    .HasColumnName("Ot_Partiq")
                    .HasColumnType("int(5)");

                entity.Property(e => e.PasswordHash).HasColumnType("longtext");

                entity.Property(e => e.PhoneNumber).HasColumnType("longtext");

                entity.Property(e => e.PhoneNumberConfirmed).HasColumnType("bit(1)");

                entity.Property(e => e.SecurityStamp).HasColumnType("longtext");

                entity.Property(e => e.TwoFactorEnabled).HasColumnType("bit(1)");

                entity.Property(e => e.UserName)
                    .HasMaxLength(256)
                    .IsUnicode(false);

                entity.Property(e => e.IsDeleted).HasColumnType("bit(1)");

                entity.HasOne(d => d.AdministrativeRajonNavigation)
                    .WithMany(p => p.Aspnetusers)
                    .HasForeignKey(d => d.AdministrativeRajon)
                    .HasConstraintName("FK_aspnetusers_wntoa_RajonNkod");

                entity.HasOne(d => d.OtPartiqNavigation)
                    .WithMany(p => p.Aspnetusers)
                    .HasForeignKey(d => d.OtPartiq)
                    .HasConstraintName("FK_aspnetusers_sila_PartiqIdParty");
            });

            modelBuilder.Entity<Aspnetusertokens>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.LoginProvider, e.Name });

                entity.ToTable("aspnetusertokens");

                entity.Property(e => e.UserId)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.LoginProvider)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Name)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Value).HasColumnType("longtext");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Aspnetusertokens)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_AspNetUserTokens_AspNetUsers_UserId");
            });

            modelBuilder.Entity<NLica>(entity =>
            {
                entity.ToTable("n_lica");

                entity.HasKey(e => e.Id);

                entity.HasIndex(e => e.JkKv)
                    .HasName("JK_KV");

                entity.HasIndex(e => e.Nas)
                    .HasName("NAS");

                entity.HasIndex(e => e.Obl)
                    .HasName("OBL");

                entity.HasIndex(e => e.Obs)
                    .HasName("OBS");

                entity.HasIndex(e => e.Raj)
                    .HasName("RAJ");

                entity.HasIndex(e => e.Ul)
                    .HasName("UL");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(7)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Ap)
                    .HasColumnName("AP")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Blok)
                    .HasColumnName("BLOK")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Egn)
                    .IsRequired()
                    .HasColumnName("EGN")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Et)
                    .HasColumnName("ET")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Im1)
                    .HasColumnName("IM1")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Im2)
                    .HasColumnName("IM2")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Im3)
                    .HasColumnName("IM3")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Impmessage)
                    .HasColumnName("impmessage")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Impstatus)
                    .HasColumnName("impstatus")
                    .HasColumnType("int(11)");

                entity.Property(e => e.JkKv)
                    .HasColumnName("JK_KV")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Koga).HasColumnName("KOGA");

                entity.Property(e => e.Nas)
                    .HasColumnName("NAS")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Naz)
                    .HasColumnName("NAZ")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("BG");

                entity.Property(e => e.Nom)
                    .HasColumnName("NOM")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Obl)
                    .HasColumnName("OBL")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Obra)
                    .HasMaxLength(16)
                    .IsUnicode(false);

                entity.Property(e => e.Obs)
                    .HasColumnName("OBS")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Pas1)
                    .HasColumnName("PAS1")
                    .HasMaxLength(1)
                    .IsUnicode(false);

                entity.Property(e => e.Pas2)
                    .HasColumnName("PAS2")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Pas3).HasColumnName("PAS3");

                entity.Property(e => e.Pas4)
                    .HasColumnName("PAS4")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Pk)
                    .HasColumnName("PK")
                    .HasMaxLength(4)
                    .IsUnicode(false);

                entity.Property(e => e.Raj)
                    .HasColumnName("RAJ")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Spec)
                    .HasMaxLength(16)
                    .IsUnicode(false);

                entity.Property(e => e.Tel)
                    .HasColumnName("TEL")
                    .HasMaxLength(14)
                    .IsUnicode(false);

                entity.Property(e => e.Ul)
                    .HasColumnName("UL")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.User)
                    .HasColumnName("USER")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Vh)
                    .HasColumnName("VH")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.VidId)
                    .HasColumnName("Vid_id")
                    .HasColumnType("int(1)");
            });

            modelBuilder.Entity<NLicaDopylnenie>(entity =>
            {
                entity.ToTable("n_lica_dopylnenie");

                entity.HasIndex(e => e.IdLice)
                    .HasName("FK_nlicadop_nlica");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(7)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Idcodeposition)
                    .HasColumnName("Idcodeposition")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.IdLice)
                    .HasColumnName("Id_Lice")
                    .HasColumnType("int(7)");

                entity.Property(e => e.Status)
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("1");

                entity.Property(e => e.User)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.VidCodetable)
                    .HasColumnName("VidCodetable")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("3");

                entity.HasOne(d => d.IdLiceNavigation)
                    .WithMany(p => p.NLicaDopylnenie)
                    .HasForeignKey(d => d.IdLice)
                    .HasConstraintName("FK_nlicadop_nlica");
            });

            modelBuilder.Entity<NLicaImport>(entity =>
            {
                entity.ToTable("n_lica_import");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .HasColumnType("int(11)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Egn)
                    .IsRequired()
                    .HasColumnName("egn")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Im1)
                    .IsRequired()
                    .HasColumnName("im1")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Im2)
                    .IsRequired()
                    .HasColumnName("im2")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Im3)
                    .IsRequired()
                    .HasColumnName("im3")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Obra)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Opisanie)
                    .HasColumnName("opisanie")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Rolja)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Sik)
                    .IsRequired()
                    .HasColumnName("SIK")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Spec)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasColumnName("status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Tel)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.User)
                    .IsRequired()
                    .HasColumnName("user")
                    .HasMaxLength(128)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NLicaIzbori>(entity =>
            {
                entity.ToTable("n_lica_izbori");

                entity.HasKey(e => e.Id);

                entity.HasIndex(e => e.IdLice)
                    .HasName("n_lica_izbori_ibfk_1");

                entity.HasIndex(e => e.IdSik)
                    .HasName("FK_lica_izbori_siks_1");

                entity.HasIndex(e => e.IdSila)
                    .HasName("FK_lica_izbori_wnsila");

                entity.HasIndex(e => e.Toa)
                    .HasName("FK_n_lica_izbori_wntoa");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(7)")
                    .ValueGeneratedOnAdd(); 

                entity.Property(e => e.CodeRolia)
                    .IsRequired()
                    .HasColumnName("Code_rolia")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Hasmaxincome)
                    .HasColumnName("hasmaxincome")
                    .HasColumnType("int(1) unsigned zerofill");

                entity.Property(e => e.IdLice)
                    .HasColumnName("ID_Lice")
                    .HasColumnType("int(7)");

                entity.Property(e => e.IdSik)
                    .HasColumnName("Id_Sik")
                    .HasColumnType("int(10)");

                entity.Property(e => e.IdSila)
                    .HasColumnName("id_sila")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ImeRolia)
                    .HasColumnName("Ime_rolia")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.IzbAlias)
                    .HasColumnName("Izb_Alias")
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasDefaultValueSql("MI2019");

                entity.Property(e => e.Koga).HasColumnName("KOGA");

                entity.Property(e => e.Re)
                    .HasMaxLength(40)
                    .IsUnicode(false);

                entity.Property(e => e.Toa)
                    .HasColumnName("TOA")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Tur).HasColumnType("int(1)");

                entity.Property(e => e.User)
                    .HasColumnName("USER")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdLiceNavigation)
                    .WithMany(p => p.NLicaIzbori)
                    .HasForeignKey(d => d.IdLice)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("n_lica_izbori_ibfk_1");

                entity.HasOne(d => d.IdSilaNavigation)
                    .WithMany(p => p.NLicaIzbori)
                    .HasForeignKey(d => d.IdSila)
                    .HasConstraintName("FK_lica_izbori_wnsila");

                entity.HasOne(d => d.ToaNavigation)
                    .WithMany(p => p.NLicaIzbori)
                    .HasForeignKey(d => d.Toa)
                    .HasConstraintName("FK_n_lica_izbori_wntoa");
            });

            modelBuilder.Entity<NLicePariZanap>(entity =>
            {
                entity.ToTable("n_lice_pari_zanap");

                entity.HasIndex(e => e.IdLice)
                    .HasName("FK_nlicaparizanap_nlica");

                entity.Property(e => e.Id)
                    .HasColumnType("int(8)")
                    .ValueGeneratedNever();

                entity.Property(e => e.CodeDancoef)
                    .HasColumnName("Code_dancoef")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.IdLice)
                    .HasColumnName("ID_Lice")
                    .HasColumnType("int(8)");

                entity.Property(e => e.Pari).HasColumnType("decimal(10,4)");

                entity.HasOne(d => d.IdLiceNavigation)
                    .WithMany(p => p.NLicePariZanap)
                    .HasForeignKey(d => d.IdLice)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_nlicaparizanap_nlica");
            });

            modelBuilder.Entity<NLicePariZaplashtane>(entity =>
            {
                entity.ToTable("n_lice_pari_zaplashtane");

                entity.HasIndex(e => e.IdLice)
                    .HasName("FK_nlicaparizaplashtane_nlica");

                entity.Property(e => e.Id)
                    .HasColumnType("int(8)")
                    .ValueGeneratedNever();

                entity.Property(e => e.CodePossition)
                    .HasColumnName("Code_possition")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.CodeTable)
                    .HasColumnName("Code_Table")
                    .HasColumnType("char(1)");

                entity.Property(e => e.IdLice)
                    .HasColumnName("ID_Lice")
                    .HasColumnType("int(8)");

                entity.Property(e => e.Pari).HasColumnType("decimal(10,4)");

                entity.HasOne(d => d.IdLiceNavigation)
                    .WithMany(p => p.NLicePariZaplashtane)
                    .HasForeignKey(d => d.IdLice)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_nlicaparizaplashtane_nlica");
            });

            modelBuilder.Entity<NListCodepositions>(entity =>
            {
                entity.ToTable("n_list_codepositions");

                entity.HasKey(e => e.Id);

                entity.HasIndex(e => e.Pkode)
                    .HasName("FK_CODEPOS_CODETABL");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(5)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.IzbAllias)
                    .IsRequired()
                    .HasColumnName("IZB_ALLIAS")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.Nkode)
                    .HasColumnName("NKODE")
                    .HasColumnType("int(3)");

                entity.Property(e => e.Pkode)
                    .HasColumnName("PKODE")
                    .HasColumnType("int(4)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Status)
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("1");

                entity.HasOne(d => d.PkodeNavigation)
                    .WithMany(p => p.NListCodepositions)
                    .HasForeignKey(d => d.Pkode)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CODEPOS_CODETABL");
            });

            modelBuilder.Entity<NListCodetables>(entity =>
            {
                entity.ToTable("n_list_codetables");

                entity.HasKey(e => e.Nkode);

                entity.Property(e => e.Nkode)
                    .HasColumnName("NKODE")
                    .HasColumnType("int(4)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("1");
            });

            modelBuilder.Entity<NLog>(entity =>
            {
                entity.ToTable("n_log");

                entity.HasKey(e => e.IdLog);

                entity.Property(e => e.IdLog)
                    .HasColumnName("Id_LOG")
                    .HasColumnType("int(11)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Aaa)
                    .HasColumnName("AAA")
                    .HasColumnType("int(1)");

                entity.Property(e => e.Action)
                    .HasColumnName("ACTION")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ImeObrabotka)
                    .IsRequired()
                    .HasColumnName("Ime_Obrabotka")
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.KodObrabotka)
                    .IsRequired()
                    .HasColumnName("Kod_Obrabotka")
                    .HasMaxLength(4)
                    .IsUnicode(false);

                entity.Property(e => e.User)
                    .IsRequired()
                    .HasMaxLength(30)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NNomenclatures>(entity =>
            {
                entity.ToTable("n_nomenclatures");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .HasColumnType("int(11)")
                    .ValueGeneratedOnAdd(); 

                entity.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasColumnName("status")
                    .HasColumnType("smallint(1)");

                entity.Property(e => e.Table)
                    .HasColumnName("table")
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NStatistics>(entity =>
            {
                entity.ToTable("n_statistics");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .HasColumnType("int(11)")
                    .ValueGeneratedOnAdd(); 

                entity.Property(e => e.Longdescription)
                    .HasColumnName("longdescription")
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.Shortdescription)
                    .HasColumnName("shortdescription")
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NToaMain>(entity =>
            {
                entity.ToTable("n_toa_main");

                entity.HasKey(e => e.Nrec);

                entity.HasIndex(e => e.JkKv)
                    .HasName("JK_KV");

                entity.HasIndex(e => e.Nas)
                    .HasName("NAS");

                entity.HasIndex(e => e.Obl)
                    .HasName("OBL");

                entity.HasIndex(e => e.Obs)
                    .HasName("OBS");

                entity.HasIndex(e => e.Raj)
                    .HasName("RAJ");

                entity.HasIndex(e => e.Toa)
                    .HasName("FK_MASTER_WNTOA");

                entity.HasIndex(e => e.Ul)
                    .HasName("UL");

                entity.Property(e => e.Nrec).HasColumnType("int(11)").ValueGeneratedOnAdd();

                entity.Property(e => e.Ano)
                    .HasColumnName("ANO")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Ap)
                    .HasColumnName("AP")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Blok)
                    .HasColumnName("BLOK")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Bul)
                    .HasMaxLength(13)
                    .IsUnicode(false);

                entity.Property(e => e.Epod)
                    .HasColumnName("EPOD")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.Et)
                    .HasColumnName("ET")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Ime)
                    .HasColumnName("IME")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.Ipod)
                    .HasColumnName("IPOD")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.IzbAlias)
                    .HasColumnName("IZB_ALIAS")
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasDefaultValueSql("MI2019");

                entity.Property(e => e.Izr)
                    .HasMaxLength(15)
                    .IsUnicode(false);

                entity.Property(e => e.JkKv)
                    .HasColumnName("JK_KV")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Nas)
                    .HasColumnName("NAS")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Nom)
                    .HasColumnName("NOM")
                    .HasMaxLength(4)
                    .IsUnicode(false);

                entity.Property(e => e.Nsik).HasColumnType("int(11)");

                entity.Property(e => e.Obl)
                    .HasColumnName("OBL")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Obs)
                    .HasColumnName("OBS")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Pk)
                    .HasColumnName("PK")
                    .HasMaxLength(4)
                    .IsUnicode(false);

                entity.Property(e => e.Pred)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Pris)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.R1)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.R2)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Raj)
                    .HasColumnName("RAJ")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Sekr)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.StatusMaster)
                    .HasColumnName("Status_Master")
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("1");

                entity.Property(e => e.Tel)
                    .HasColumnName("TEL")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Tel1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Toa)
                    .HasColumnName("TOA")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Tur)
                    .HasColumnType("tinyint(1)")
                    .HasDefaultValueSql("1");

                entity.Property(e => e.Ul)
                    .HasColumnName("UL")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Vh)
                    .HasColumnName("VH")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.HasOne(d => d.JkKvNavigation)
                    .WithMany(p => p.NToaMain)
                    .HasForeignKey(d => d.JkKv)
                    .HasConstraintName("n_toa_main_ibfk_8");

                entity.HasOne(d => d.NasNavigation)
                    .WithMany(p => p.NToaMain)
                    .HasForeignKey(d => d.Nas)
                    .HasConstraintName("n_toa_main_ibfk_3");

                entity.HasOne(d => d.OblNavigation)
                    .WithMany(p => p.NToaMain)
                    .HasForeignKey(d => d.Obl)
                    .HasConstraintName("n_toa_main_ibfk_5");

                entity.HasOne(d => d.ObsNavigation)
                    .WithMany(p => p.NToaMain)
                    .HasForeignKey(d => d.Obs)
                    .HasConstraintName("n_toa_main_ibfk_6");

                entity.HasOne(d => d.RajNavigation)
                    .WithMany(p => p.NToaMainRajNavigation)
                    .HasForeignKey(d => d.Raj)
                    .HasConstraintName("n_toa_main_ibfk_1");

                entity.HasOne(d => d.ToaNavigation)
                    .WithMany(p => p.NToaMainToaNavigation)
                    .HasForeignKey(d => d.Toa)
                    .HasConstraintName("FK_MASTER_WNTOA");

                entity.HasOne(d => d.UlNavigation)
                    .WithMany(p => p.NToaMain)
                    .HasForeignKey(d => d.Ul)
                    .HasConstraintName("n_toa_main_ibfk_7");
            });

            modelBuilder.Entity<NTopDancoef>(entity =>
            {
                entity.ToTable("n_top_dancoef");

                entity.HasKey(e => e.IdCoef);

                entity.Property(e => e.IdCoef)
                    .HasColumnName("ID_Coef")
                    .HasColumnType("int(6)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.CoefStoinost)
                    .HasColumnName("Coef_stoinost")
                    .HasColumnType("decimal(6,4)");

                entity.Property(e => e.FieldName)
                    .HasColumnName("Field_name")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.NapKolona)
                    .HasColumnName("nap_colona")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.IzbAllias)
                    .IsRequired()
                    .HasColumnName("IZB_ALLIAS")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Nred)
                    .IsRequired()
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.StatusCoef)
                    .HasColumnName("Status_coef")
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Tekst)
                    .HasMaxLength(60)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NTopMain>(entity =>
            {
                entity.ToTable("n_top_main");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(6)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Date1tur).HasColumnName("DATE1TUR");

                entity.Property(e => e.Date2tur).HasColumnName("DATE2TUR");

                entity.Property(e => e.Description)
                    .HasMaxLength(40)
                    .IsUnicode(false);

                entity.Property(e => e.IzbAlias)
                    .HasColumnName("IZB_ALIAS")
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasDefaultValueSql("NULL");

                entity.Property(e => e.StatusParameters)
                    .HasColumnName("Status_parameters")
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("1");
            });

            modelBuilder.Entity<NTopParameters>(entity =>
            {
                entity.ToTable("n_top_parameters");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(6)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Description)
                    .HasMaxLength(40)
                    .IsUnicode(false);

                entity.Property(e => e.IzbAlias)
                    .IsRequired()
                    .HasColumnName("IZB_ALIAS")
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasDefaultValueSql("MI2019");

                entity.Property(e => e.Kod)
                    .IsRequired()
                    .HasColumnName("KOD")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.StatusParameters)
                    .HasColumnName("Status_parameters")
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("1");

                entity.Property(e => e.Znachenie)
                    .HasMaxLength(40)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NTopPartkvoti>(entity =>
            {
                entity.ToTable("n_top_partkvoti");

                entity.Property(e => e.Id)
                    .HasColumnType("int(6)")
                    .ValueGeneratedNever();

                entity.Property(e => e.CodeWnsila)
                    .HasColumnName("code_wnsila")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.IzbAlias)
                    .IsRequired()
                    .HasColumnName("Izb_Alias")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.IzbRajon)
                    .HasColumnName("Izb_rajon")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Koga).HasColumnName("KOGA");

                entity.Property(e => e.SikClenove)
                    .HasColumnName("SIK_Clenove")
                    .HasColumnType("int(4)");

                entity.Property(e => e.CodeRolja)
                    .HasColumnName("Code_rolia")
                    .HasColumnType("int(4)");

                entity.Property(e => e.StatusKvoti)
                    .HasColumnName("Status_kvoti")
                    .HasColumnType("int(1)");

                entity.Property(e => e.Toa)
                    .HasColumnName("TOA")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.User)
                    .HasColumnName("USER")
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<SysMain>(entity =>
            {
                entity.ToTable("sys_main");
            });

            modelBuilder.Entity<NormiOperacii>(entity =>
            {
                entity.ToTable("normi_operacii");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(7)")
                    .ValueGeneratedNever();

                entity.Property(e => e.IzbAllias)
                    .HasColumnName("Izb_allias")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Pari).HasColumnType("decimal(6,2)");

                entity.Property(e => e.Status).HasColumnType("int(1)");

                entity.Property(e => e.Tur).HasColumnType("int(1)");

                entity.Property(e => e.User)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.VidCodetable)
                    .HasColumnName("Vid_codetable")
                    .HasColumnType("char(1)")
                    .HasDefaultValueSql("3");

                entity.Property(e => e.Idcodeposition)
                    .HasColumnName("Idcodeposition")
                    .HasMaxLength(3)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NormiPriznaci>(entity =>
            {
                entity.ToTable("normi_priznaci");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(7)")
                    .ValueGeneratedNever();

                entity.Property(e => e.IzbAllias)
                    .HasColumnName("Izb_allias")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Pari).HasColumnType("decimal(6,2)");

                entity.Property(e => e.Status).HasColumnType("int(1)");

                entity.Property(e => e.Tur).HasColumnType("int(1)");

                entity.Property(e => e.User)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.VidCodetable)
                    .HasColumnName("Vid_codetable")
                    .HasColumnType("char(1)")
                    .HasDefaultValueSql("2");

                entity.Property(e => e.Idcodeposition)
                    .HasColumnName("Idcodeposition")
                    .HasMaxLength(3)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<NormiRoli>(entity =>
            {
                entity.ToTable("normi_roli");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(7)")
                    .ValueGeneratedNever();

                entity.Property(e => e.IzbAllias)
                    .HasColumnName("Izb_allias")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Pari).HasColumnType("decimal(6,2)");

                entity.Property(e => e.Status).HasColumnType("int(1)");

                entity.Property(e => e.Tur).HasColumnType("int(1)");

                entity.Property(e => e.User)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.VidCodetable_1)
                    .HasColumnName("Vid_Codetable_1")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("1");

                entity.Property(e => e.VidCodetable)
                    .HasColumnName("Vid_Codetable")
                    .HasColumnType("char(1)")
                    .HasDefaultValueSql("4");

                entity.Property(e => e.Idcodeposition)
                    .HasColumnName("Idcodeposition")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Idcodeposition_1)
                    .HasColumnName("Idcodeposition_1")
                    .HasMaxLength(3)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Siks>(entity =>
            {              
                entity.ToTable("siks");

                entity.HasKey(e => e.IdSek);

                entity.HasIndex(e => e.JkKv)
                    .HasName("JK_KV");

                entity.HasIndex(e => e.Nas)
                    .HasName("NAS");

                entity.HasIndex(e => e.Obl)
                    .HasName("Obl");

                entity.HasIndex(e => e.Obs)
                    .HasName("Obs");

                entity.HasIndex(e => e.Toa)
                    .HasName("FK_SIKS_WNTOA");

                entity.HasIndex(e => e.Ul)
                    .HasName("UL");

                entity.Property(e => e.IdSek)
                    .HasColumnName("Id_sek")
                    .HasColumnType("int(10)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.AaBbCc)
                    .IsRequired()
                    .HasColumnName("AA_BB_CC")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.AdrIme)
                    .HasColumnName("ADR_IME")
                    .HasMaxLength(60)
                    .IsUnicode(false);

                entity.Property(e => e.Blok)
                    .HasColumnName("BLok")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.IzbAlias)
                    .IsRequired()
                    .HasColumnName("Izb_Alias")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.IzbRajon)
                    .IsRequired()
                    .HasColumnName("Izb_rajon")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.JkKv)
                    .HasColumnName("JK_KV")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Nas)
                    .HasColumnName("NAS")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Nom)
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Obl)
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Obs)
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Sik)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.StatusSekcia)
                    .HasColumnName("Status_Sekcia")
                    .HasColumnType("int(1)");

                entity.Property(e => e.Tel)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Toa)
                    .IsRequired()
                    .HasColumnName("TOA")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Tur)
                    .HasColumnName("TUR")
                    .HasColumnType("int(1)");

                entity.Property(e => e.Ul)
                    .HasColumnName("UL")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.User)
                    .HasColumnName("USER")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(d => d.NasNavigation)
                    .WithMany(p => p.Siks)
                    .HasForeignKey(d => d.Nas)
                    .HasConstraintName("siks_ibfk_3");

                entity.HasOne(d => d.OblNavigation)
                    .WithMany(p => p.Siks)
                    .HasForeignKey(d => d.Obl)
                    .HasConstraintName("siks_ibfk_1");

                entity.HasOne(d => d.ObsNavigation)
                    .WithMany(p => p.Siks)
                    .HasForeignKey(d => d.Obs)
                    .HasConstraintName("siks_ibfk_2");

                entity.HasOne(d => d.ToaNavigation)
                    .WithMany(p => p.Siks)
                    .HasForeignKey(d => d.Toa)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SIKS_WNTOA");
            });

            modelBuilder.Entity<SiksVidove>(entity =>
            {
                entity.HasKey(s => new { s.Id });

                entity.ToTable("siks_vidove");

                entity.HasIndex(e => e.IdSik)
                    .HasName("FK_SIKS_VIDOVE_SIKS");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(7)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Idcodeposition)
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Vid_codetable).HasColumnType("int(11)");

                entity.Property(e => e.IdSik)
                    .HasColumnName("Id_Sik")
                    .HasColumnType("int(11)");

                entity.Property(e => e.IzbAllias)
                    .IsRequired()
                    .HasColumnName("IZB_allias")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasColumnType("int(1)")
                    .HasDefaultValueSql("1");

                entity.Property(e => e.Tur).HasColumnType("int(1)");

                entity.HasOne(d => d.IdSikNavigation)
                    .WithMany(p => p.SiksVidove)
                    .HasForeignKey(d => d.IdSik)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SIKS_VIDOVE_SIKS");
            });

            modelBuilder.Entity<SysTables>(entity =>
            {
                entity.ToTable("sys_tables");

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnasm>(entity =>
            {
                entity.ToTable("wnasm");

                entity.HasKey(e => e.Nkod);

                entity.Property(e => e.Nkod)
                    .HasColumnName("nkod")
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Kmetstvo)
                    .HasMaxLength(8)
                    .IsUnicode(false);

                entity.Property(e => e.Nime)
                    .HasColumnName("nime")
                    .HasMaxLength(25)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wndocs>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wndocs");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.IzbAlias)
                    .HasColumnName("Izb_Alias")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(40)
                    .IsUnicode(false);

                entity.Property(e => e.StatusNdocs)
                    .HasColumnName("Status_ndocs")
                    .HasColumnType("tinyint(1)")
                    .HasDefaultValueSql("1");
            });

            modelBuilder.Entity<WnjkKv>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnjk_kv");

                entity.Property(e => e.Nkod)
                    .HasColumnName("nkod")
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("nime")
                    .HasMaxLength(30)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnkmetstva>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnkmetstva");

                entity.Property(e => e.Nkod)
                    .HasColumnName("nkod")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("nime")
                    .HasMaxLength(40)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnmaks>(entity =>
            {
                entity.HasKey(e => e.IdShablon);

                entity.ToTable("wnmaks");

                entity.Property(e => e.IdShablon)
                    .HasColumnName("ID_shablon")
                    .HasColumnType("int(5)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.IzbAlias)
                    .HasColumnName("Izb_Alias")
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasDefaultValueSql("MI2019");

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(40)
                    .IsUnicode(false);

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.StatusSh)
                    .HasColumnName("Status_sh")
                    .HasColumnType("tinyint(1)")
                    .HasDefaultValueSql("0");
            });

            modelBuilder.Entity<Wnnaz>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnnaz");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(25)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnnru>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnnru");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(30)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnobl>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnobl");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(30)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnobs>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnobs");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Ekatte)
                    .HasColumnName("ekatte")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(28)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnsila>(entity =>
            {
                entity.ToTable("wnsila");

                entity.HasKey(e => e.IdParty);

                entity.Property(e => e.IdParty)
                    .HasColumnName("ID_Party")
                    .HasColumnType("int(5)")
                    .ValueGeneratedOnAdd();  

                entity.Property(e => e.IzbAlias)
                    .IsRequired()
                    .HasColumnName("IZB_ALIAS")
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasDefaultValueSql("0");

                entity.Property(e => e.LegalKod)
                    .HasColumnName("Legal_Kod")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(40)
                    .IsUnicode(false);

                entity.Property(e => e.Nkod)
                    .IsRequired()
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.ShortName)
                    .HasColumnName("Short_name")
                    .HasMaxLength(15)
                    .IsUnicode(false);

                entity.Property(e => e.StatusPartii)
                    .HasColumnName("Status_Partii")
                    .HasColumnType("int(1)");
            });

            modelBuilder.Entity<Wnspec>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnspec");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(16)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnszem>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnszem");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(16)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wntoa>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wntoa");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(16)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<WntoaIzbraion>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wntoa_izbraion");

                entity.Property(e => e.Nkod)
                    .HasColumnName("NKOD")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.BroiSik)
                    .HasColumnName("BROI_SIK")
                    .HasColumnType("int(11)");

                entity.Property(e => e.IzbR)
                    .HasColumnName("IZB_R")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.Nime)
                    .HasColumnName("NIME")
                    .HasMaxLength(16)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Wnuli>(entity =>
            {
                entity.HasKey(e => e.Nkod);

                entity.ToTable("wnuli");

                entity.Property(e => e.Nkod)
                    .HasColumnName("nkod")
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Nime)
                    .HasColumnName("nime")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.WnasmNkod)
                    .HasColumnName("wnasm_nkod")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.WnuliNkod)
                    .HasColumnName("wnuli_nkod")
                    .HasMaxLength(5)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<SiksPodvijni>(entity =>
            {
                entity.ToTable("siks_podvijni");

                entity.HasKey(s => new { s.Id });

                entity.HasIndex(e => e.IdSik)
                    .HasName("FK_SIKS_PODVIJNI_SIKS");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasColumnType("int(11)")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.IdSik)
                    .HasColumnName("Id_Sik")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Toa)
                    .IsRequired()
                    .HasMaxLength(16)
                    .IsUnicode(false);

                entity.Property(e => e.VoterNumbere)
                    .IsRequired()
                    .HasColumnName("Voter_number")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Koga)
                    .IsRequired()
                    .HasColumnName("Koga");

                entity.Property(e => e.User)
                    .IsRequired()
                    .HasColumnName("USER")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(p => p.IdSikNavigation)
                    .WithMany(p => p.SiksPodvijni)
                    .HasForeignKey(d => d.IdSik)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SIKS_PODVIJNI_SIKS");

            });
        }
    }
}
