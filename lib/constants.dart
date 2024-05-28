const String appUsageTermsTitle = 'Lietotnes izmantošanas noteikumi';
const String appUsageTerms =
    '''Šajā lietotnē ir iekļauta informācija tikai par tām vielām un metodēm, kuras ir aizliegts lietot sportā un ir iekļautas Pasaules Antidopinga aģentūras Aizliegto vielu un metožu sarakstā. Lietotnē ir pieejama informācija tikai par tām zālēm, kuras ir iespējams iegādāties Latvijā. Lietotnē nav pieejama informācija par Uztura bagātinātājiem.\n
Ja šajā lietotnē, neatrodat nepieciešamo informāciju par lietošanu sportā, tas nenozīmē, ka vielas vai metodes lietošana sportā nav aizliegta.\n
Informācija par lietošanu sportā sagatavota, izmantojot Latvijas Antidopinga biroja publicētos datus Latvijas Atvērto datu portālā un Zāļu valsts aģentūras Latvijas Zāļu reģistra atvērtos datus. Lietotnē informācija par lietošanu sportā ir sagatavota informatīvos nolūkos, tā nav uzskatāma kā autoritatīva informācija par vielas vai metodes statusu sportā. Lietotne iespēju robežās sniedz aktuālu un precīzu informāciju, taču neuzņemas atbildību par kļūdām vai neprecizitātēm. Vēršam uzmanību, ka īpašos apstākļos vai situācijās nepieciešama ārsta vai farmaceita konsultācija. Lūdzu, ņemiet vērā, ka informācija par jaunām zālēm vai izmaiņas aizliegto vielu un metožu sarakstā tiek atjaunota pēc šo zāļu pievienošanas Latvijas Zāļu reģistrā vai saraksta publicēšanas Pasaules Antidopinga aģentūras mājaslapā.''';
const List<String> termsPrompt = [
  'Lai izmantotu lietotni, Tev jāapstiprina ',
  'lietošanas nosacījumi',
  '.'
];
const String acceptTerms = 'Apstiprinu lietotnes lietošanas nosacījumus';
const String emptyResults = 'Netika atrasts neviens medikaments, lūdzu pārbaudi ievadīto frāzi un mēģini vēlreiz';
