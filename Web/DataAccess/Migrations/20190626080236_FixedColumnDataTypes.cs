using Microsoft.EntityFrameworkCore.Migrations;

namespace DataAccess.Migrations
{
    public partial class FixedColumnDataTypes : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "Vid_sekcia",
                schema: "votingregister",
                table: "normi_roli",
                unicode: false,
                maxLength: 3,
                nullable: false,
                oldClrType: typeof(string),
                oldUnicode: false,
                oldMaxLength: 3,
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "Vid_rolia",
                schema: "votingregister",
                table: "normi_roli",
                unicode: false,
                maxLength: 3,
                nullable: false,
                oldClrType: typeof(string),
                oldUnicode: false,
                oldMaxLength: 3,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codetale_2",
                schema: "votingregister",
                table: "normi_roli",
                type: "char(1)",
                nullable: false,
                defaultValueSql: "4",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldNullable: true,
                oldDefaultValueSql: "4");

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codetable",
                schema: "votingregister",
                table: "normi_roli",
                type: "char(1)",
                nullable: false,
                defaultValueSql: "1",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldNullable: true,
                oldDefaultValueSql: "1");

            migrationBuilder.AlterColumn<int>(
                name: "Vid_priznak",
                schema: "votingregister",
                table: "normi_priznaci",
                unicode: false,
                maxLength: 3,
                nullable: false,
                oldClrType: typeof(string),
                oldUnicode: false,
                oldMaxLength: 3,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codetable",
                schema: "votingregister",
                table: "normi_priznaci",
                type: "char(1)",
                nullable: false,
                defaultValueSql: "2",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldNullable: true,
                oldDefaultValueSql: "2");

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codeT",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                type: "char(1)",
                nullable: false,
                defaultValueSql: "3",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldNullable: true,
                oldDefaultValueSql: "3");

            migrationBuilder.AlterColumn<int>(
                name: "Code_operacia",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                unicode: false,
                maxLength: 3,
                nullable: false,
                oldClrType: typeof(string),
                oldUnicode: false,
                oldMaxLength: 3,
                oldNullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Vid_sekcia",
                schema: "votingregister",
                table: "normi_roli",
                unicode: false,
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 3);

            migrationBuilder.AlterColumn<string>(
                name: "Vid_rolia",
                schema: "votingregister",
                table: "normi_roli",
                unicode: false,
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 3);

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codetale_2",
                schema: "votingregister",
                table: "normi_roli",
                type: "char(1)",
                nullable: true,
                defaultValueSql: "4",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldDefaultValueSql: "4");

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codetable",
                schema: "votingregister",
                table: "normi_roli",
                type: "char(1)",
                nullable: true,
                defaultValueSql: "1",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldDefaultValueSql: "1");

            migrationBuilder.AlterColumn<string>(
                name: "Vid_priznak",
                schema: "votingregister",
                table: "normi_priznaci",
                unicode: false,
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 3);

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codetable",
                schema: "votingregister",
                table: "normi_priznaci",
                type: "char(1)",
                nullable: true,
                defaultValueSql: "2",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldDefaultValueSql: "2");

            migrationBuilder.AlterColumn<string>(
                name: "Vid_codeT",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                type: "char(1)",
                nullable: true,
                defaultValueSql: "3",
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldDefaultValueSql: "3");

            migrationBuilder.AlterColumn<string>(
                name: "Code_operacia",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                unicode: false,
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 3);
        }
    }
}
