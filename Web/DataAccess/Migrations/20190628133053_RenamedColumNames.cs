using Microsoft.EntityFrameworkCore.Migrations;

namespace DataAccess.Migrations
{
    public partial class RenamedColumNames : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Codetable",
                schema: "votingregister",
                table: "siks_vidove",
                newName: "Vid_codetable");

            migrationBuilder.RenameColumn(
                name: "Codeposition",
                schema: "votingregister",
                table: "siks_vidove",
                newName: "Idcodeposition");

            migrationBuilder.RenameColumn(
                name: "Vid_codeT",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                newName: "VidCodetable").Annotation("Relational:ColumnType", "int");

            migrationBuilder.RenameColumn(
                name: "Code_operacia",
                schema: "votingregister",
                table: "n_lica_dopylnenie",
                newName: "Idcodeposition").Annotation("Relational:ColumnType", "int"); 

            migrationBuilder.RenameColumn(
                name: "Vid_rolia",
                schema: "votingregister",
                table: "normi_roli",
                newName: "Idcodeposition").Annotation("Relational:ColumnType", "int");

            migrationBuilder.RenameColumn(
                name: "Vid_sekcia",
                schema: "votingregister",
                table: "normi_roli",
                newName: "Idcodeposition_1").Annotation("Relational:ColumnType", "int");

            migrationBuilder.RenameColumn(
                 name: "Vid_codetable",
                 schema: "votingregister",
                 table: "normi_roli",
                 newName: "Vid_codetable_1").Annotation("Relational:ColumnType", "int");

            migrationBuilder.RenameColumn(
                 name: "Vid_codetale_2",
                 schema: "votingregister",
                 table: "normi_roli",
                 newName: "Vid_codetable").Annotation("Relational:ColumnType", "int");

            migrationBuilder.RenameColumn(
                name: "Vid_priznak",
                schema: "votingregister",
                table: "normi_priznaci",
                newName: "Idcodeposition").Annotation("Relational:ColumnType", "int");

            migrationBuilder.RenameColumn(
                name: "Vid_operacia",
                schema: "votingregister",
                table: "normi_operacii",
                newName: "Idcodeposition").Annotation("Relational:ColumnType", "int");

            migrationBuilder.RenameColumn(
                name: "Fieldl_name_OLD",
                schema: "votingregister",
                table: "n_top_dancoef",
                newName: "Field_name").Annotation("Relational:ColumnType", "varchar(10)"); ;

            migrationBuilder.RenameColumn(
                name: "Field_name_NEW",
                schema: "votingregister",
                table: "n_top_dancoef",
                newName: "nap_colona").Annotation("Relational:ColumnType", "int");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Vid_codetable",
                schema: "votingregister",
                table: "siks_vidove",
                newName: "Codetable");

            migrationBuilder.RenameColumn(
                name: "Idcodeposition",
                schema: "votingregister",
                table: "siks_vidove",
                newName: "Codeposition");
        }
    }
}
