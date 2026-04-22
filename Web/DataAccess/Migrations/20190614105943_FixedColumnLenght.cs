using Microsoft.EntityFrameworkCore.Migrations;

namespace DataAccess.Migrations
{
    public partial class FixedColumnLenght : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "Codetable",
                schema: "votingregister",
                table: "siks_vidove",
                type: "int(11)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "char(1)");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Codetable",
                schema: "votingregister",
                table: "siks_vidove",
                type: "char(1)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int(11)");
        }
    }
}
