
namespace Repository.Interfaces.List
{
    using DTO;
    using System.Collections.Generic;

    public interface IListRepository
    {
        ICollection<ListCodePositionDto> GetCodePositions(int pKode);
    }
}
