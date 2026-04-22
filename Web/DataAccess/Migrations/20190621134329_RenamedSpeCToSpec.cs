using Microsoft.EntityFrameworkCore.Migrations;

namespace DataAccess.Migrations
{
    public partial class RenamedSpeCToSpec : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "SpeС",
                schema: "votingregister",
                table: "n_lica",
                newName: "Spec");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Spec",
                schema: "votingregister",
                table: "n_lica",
                newName: "SpeС");
        }
    }
}
