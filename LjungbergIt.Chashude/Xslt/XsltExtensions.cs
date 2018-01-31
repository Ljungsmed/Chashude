using Sitecore.Data.Items;
using Sitecore.Globalization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LjungbergIt.Chashude.Xslt
{
    public class XsltExtensions
    {
        public string ReturnUrl(string language)
        {
            Item currentItem = Sitecore.Context.Item;
            Language scLangauge;
            Language.TryParse(language, out scLangauge);
            Item urlItem = Sitecore.Context.Database.GetItem(currentItem.ID, scLangauge);
            int languageVersionsCount = urlItem.Versions.Count;

            string urlToReturn = "";

            if (languageVersionsCount == 0 )
            {
                urlToReturn = "/";
            }

            return (urlToReturn) ;
        }
    }
}