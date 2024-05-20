const String appUsageTermsTitle = 'Lietotnes izmantošanas noteikumi';
const String appUsageTerms =
    '''Latvijas Zāļu reģistrā ir iekļauta informācija tikai par tām vielām un metodēm, kuras ir aizliegts lietot sportā un ir iekļautas Pasaules Antidopinga aģentūras Aizliegto vielu un metožu sarakstā. Reģistrā ir pieejama informācija tikai par tām zālēm, kuras ir iespējams iegādāties Latvijā. Reģistrā nav pieejama informācija par Uztura bagātinātājiem.\n
Ja meklējot Latvijas Zāļu reģistrā, neatrodat nepieciešamo informāciju par lietošanu sportā, tas nenozīmē, ka vielas vai metodes lietošana sportā nav aizliegta.\n
Latvijas Zāļu reģistrā informāciju par lietošanu sportā sniedz Latvijas Antidopinga birojs. Reģistrā pievienotā informācija par lietošanu sportā ir iekļauta informatīvos nolūkos, tā nav uzskatāma kā autoritatīva informācija par vielas vai metodes statusu sportā. Latvijas Antidopinga birojs iespēju robežās sniedz aktuālu un precīzu informāciju, taču neuzņemas atbildību par kļūdām vai neprecizitātēm. Vēršam uzmanību, ka īpašos apstākļos vai situācijās nepieciešama ārsta vai farmaceita konsultācija. Lūdzu, ņemiet vērā, ka informācija par jaunām zālēm vai izmaiņas aizliegto vielu un metožu sarakstā tiek atjaunota pēc šo zāļu pievienošanas reģistrā vai saraksta publicēšanas Pasaules Antidopinga aģentūras mājaslapā.''';
const List<String> termsPrompt = [
  'Lai izmantotu lietotni, Tev jāapstiprina ',
  'lietošanas nosacījumi',
  '.'
];
const String acceptTerms = 'Apstiprinu lietotnes lietošanas nosacījumus';