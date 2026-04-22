using Microsoft.EntityFrameworkCore.Migrations;

namespace DataAccess.Migrations
{
    public partial class FixedColumnTypes : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "Kme",
                schema: "votingregister",
                table: "siks");

            migrationBuilder.DropColumn(
                name: "Kme",
                schema: "votingregister",
                table: "siks");

            migrationBuilder.AlterColumn<string>(
                name: "Codetable",
                schema: "votingregister",
                table: "siks_vidove",
                type: "char(1)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "char(1)",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "Codeposition",
                schema: "votingregister",
                table: "siks_vidove",
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
                name: "Codetable",
                schema: "votingregister",
                table: "siks_vidove",
                type: "char(1)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "char(1)");

            migrationBuilder.AlterColumn<string>(
                name: "Codeposition",
                schema: "votingregister",
                table: "siks_vidove",
                unicode: false,
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(int),
                oldUnicode: false,
                oldMaxLength: 3);

            migrationBuilder.AddColumn<string>(
                name: "Kme",
                schema: "votingregister",
                table: "siks",
                unicode: false,
                maxLength: 7,
                nullable: true,
                defaultValueSql: "НЕ");

            migrationBuilder.CreateIndex(
                name: "Kme",
                schema: "votingregister",
                table: "siks",
                column: "Kme");
        }
    }
}
