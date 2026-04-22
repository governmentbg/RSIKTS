using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Kvoti
{
    public class ReshetkaCompositeViewModel
    {
        public int SikMaxMembers { get; set; }

        public List<ReshetkaViewModel> ReshetkaData { get; set; }
    }
}
