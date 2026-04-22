using ServiceReference1;
using System;
using System.Security.Cryptography.X509Certificates;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace RegixClientCore
{
    class Program
    {
        static async Task Main(string[] args)
        {
            // Create the binding (previously from App.config)
            var binding = new BasicHttpBinding
            {
                MaxReceivedMessageSize = 10000000, // Set the message size
                Security = new BasicHttpSecurity
                {
                    Mode = BasicHttpSecurityMode.Transport,
                    Transport = new HttpTransportSecurity
                    {
                        ClientCredentialType = HttpClientCredentialType.Certificate
                    }
                }
            };

            // Set the endpoint address (previously from App.config)
            var endpoint = new EndpointAddress("https://service-regix.egov.bg/RegiXEntryPointV2.svc/basic");

            // Create and return the client
            var client = new RegiXEntryPointV2Client(binding, endpoint);

            // Set client certificate (from App.config)
            client.ClientCredentials.ClientCertificate.SetCertificate(
                StoreLocation.LocalMachine,
                StoreName.My,
                X509FindType.FindByThumbprint,
                "ec912002fbf7267c53357b29c2139efefa29401c"
            );

  
            RequestWrapper requestWrapper = new RequestWrapper();
            ServiceRequestData request = new ServiceRequestData();

            request.Operation = "TechnoLogica.RegiX.GraoNBDAdapter.APIService.INBDAPI.ValidPersonSearch";

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(@"<ValidPersonRequest
                            xmlns:xsd=""http://www.w3.org/2001/XMLSchema""
                            xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
                            xmlns=""http://egov.bg/RegiX/GRAO/NBD/ValidPersonRequest"">
                            <EGN>6609251782</EGN>
                          </ValidPersonRequest>");
            request.Argument = doc.DocumentElement;
   
            requestWrapper.ServiceRequestData = request;
            var response = await client.ExecuteAsync(requestWrapper);

            if (!response.ServiceResultData.HasError)
            {
                XmlElement result = response.ServiceResultData.Data.Response.Any;
                XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
                nsmgr.AddNamespace("ns", "http://egov.bg/RegiX/GRAO/NBD/ValidPersonResponse");

                string firstName = result.SelectSingleNode("ns:FirstName", nsmgr).InnerText;
                string surName = result.SelectSingleNode("ns:SurName", nsmgr).InnerText;
                string familyName = result.SelectSingleNode("ns:FamilyName", nsmgr).InnerText;
                //                string birthDate = result.SelectSingleNode("ns:BirthDate", nsmgr).InnerText;

                string name = firstName + surName + familyName;

                Console.WriteLine($"First Name: {firstName}");
                Console.WriteLine($"Sur Name: {surName}");
                Console.WriteLine($"Family Name: {familyName}");
                Console.WriteLine($"name: {name}");
            }
            else
            {
                Console.WriteLine(response.ServiceResultData.Error);
            }
        }
    }
}
