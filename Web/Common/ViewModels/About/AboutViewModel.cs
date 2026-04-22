using System;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;

namespace Common.ViewModels.About
{
    public class AboutViewModel
    {

        public string AssemblyVersion { get; set; }
        public string AssemblyTitle { get; set; }

        public AboutViewModel()
        {
            AssemblyVersion = typeof(RuntimeEnvironment)
                                .GetTypeInfo()
                                .Assembly.GetCustomAttribute<AssemblyFileVersionAttribute>()
                                .Version;

             
            DateTime dt = new FileInfo(System.Reflection.Assembly.GetExecutingAssembly().Location).LastWriteTime;
            AssemblyTitle = dt.ToString("dd/MM/yyyy HH:mm:ss");
        }

    }

}
