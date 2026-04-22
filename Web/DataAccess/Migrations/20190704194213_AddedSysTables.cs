using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using System.IO;

namespace DataAccess.Migrations
{
    public partial class AddedSysTables : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "sys_main",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false),
                    Name = table.Column<string>(nullable: true),
                    Value = table.Column<string>(nullable: true)
                });

            migrationBuilder.CreateTable(
                name: "sys_toamain",
                columns: table => new
                {
                    Izb_rajon = table.Column<string>(nullable: true),
                    Tur = table.Column<int>(nullable: false),
                    Toa = table.Column<string>(nullable: true),
                    Id = table.Column<int>(nullable: false),
                    Name = table.Column<string>(nullable: true),
                    Value = table.Column<string>(nullable: true)
                });

            migrationBuilder.CreateTable(
                name: "sys_usermain",
                columns: table => new
                {
                    User = table.Column<string>(nullable: true),
                    Id = table.Column<int>(nullable: false),
                    Name = table.Column<string>(nullable: true),
                    Value = table.Column<string>(nullable: true)
                });

            migrationBuilder.Sql(File.ReadAllText("../DataAccess/Migrations/scripts/tbcontents.sql"));

        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "SysMains");

            migrationBuilder.DropTable(
                name: "SysToaMains");

            migrationBuilder.DropTable(
                name: "SysUsermain");

            migrationBuilder.RenameColumn(
                name: "Idcodeposition",
                schema: "votingregister",
                table: "normi_priznaci",
                newName: "Vid_priznak");

            migrationBuilder.RenameColumn(
                name: "Idcodeposition",
                schema: "votingregister",
                table: "normi_operacii",
                newName: "Vid_operacia");

            migrationBuilder.RenameColumn(
                name: "VidCodetable",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                newName: "Vid_codeT");

            migrationBuilder.RenameColumn(
                name: "Idcodeposition",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                newName: "Code_operacia");

            migrationBuilder.AlterColumn<string>(
                name: "Vid_operacia",
                schema: "votingregister",
                table: "normi_operacii",
                unicode: false,
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 3);

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codeT",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                type: "char(1)",
                nullable: false,
                defaultValueSql: "3",
                oldClrType: typeof(int),
                oldType: "int(11)",
                oldDefaultValueSql: "3");
        }
    }
}
