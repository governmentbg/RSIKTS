using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Shared
{
    public class PaginationViewModel
    {
        //[JsonProperty(PropertyName = "CurrentPage")]
        public int CurrentPage { get; set; }

        public int MaxPages { get; set; }
    }
}
