using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace DataAccess.Migrations
{
    public partial class AutoIncrementOnIds : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "ID",
                schema: "votingregister",
                table: "siks_vidove",
                type: "int(7)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int(7)")
                .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "ID",
                schema: "votingregister",
                table: "siks_vidove",
                type: "int(7)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int(7)")
                .OldAnnotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);
        }
    }
}
