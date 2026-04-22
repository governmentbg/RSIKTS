using Microsoft.EntityFrameworkCore.Migrations;
using System.IO;

namespace DataAccess.Migrations
{
    public partial class AddedTipColumnToNomenklatures : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Vid_Codetable",
                schema: "votingregister",
                table: "normi_roli",
                type: "char(1)",
                nullable: false,
                defaultValueSql: "4",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldDefaultValueSql: "1");

            migrationBuilder.AddColumn<int>(
                name: "Tip",
                schema: "votingregister",
                table: "n_statistics",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Tip",
                schema: "votingregister",
                table: "n_nomenclatures",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<int>(
                name: "Code_rolia",
                schema: "votingregister",
                table: "n_lica_izbori",
                unicode: false,
                maxLength: 3,
                nullable: false,
                oldClrType: typeof(string),
                oldUnicode: false,
                oldMaxLength: 3);

           
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Vid_Codetable_1",
                schema: "votingregister",
                table: "normi_roli");

            migrationBuilder.DropColumn(
                name: "Tip",
                schema: "votingregister",
                table: "n_statistics");

            migrationBuilder.DropColumn(
                name: "Tip",
                schema: "votingregister",
                table: "n_nomenclatures");

            migrationBuilder.RenameColumn(
                name: "Vid_Codetable",
                schema: "votingregister",
                table: "normi_roli",
                newName: "Vid_codetable");

            migrationBuilder.RenameColumn(
                name: "Idcodeposition_1",
                schema: "votingregister",
                table: "normi_roli",
                newName: "Vid_sekcia");

            migrationBuilder.RenameColumn(
                name: "Idcodeposition",
                schema: "votingregister",
                table: "normi_roli",
                newName: "Vid_rolia");

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codetable",
                schema: "votingregister",
                table: "normi_roli",
                type: "char(1)",
                nullable: false,
                defaultValueSql: "1",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldDefaultValueSql: "4");

            migrationBuilder.AlterColumn<string>(
                name: "Fieldl_name_OLD",
                schema: "votingregister",
                table: "n_top_dancoef",
                unicode: false,
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 10);

            migrationBuilder.AlterColumn<string>(
                name: "Code_rolia",
                schema: "votingregister",
                table: "n_lica_izbori",
                unicode: false,
                maxLength: 3,
                nullable: false,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 3);
        }
    }
}
