class CheckListRepository{
  List<Map<String, dynamic>> List_aircrafts=[
    {
      'name aircraft':'Cessna 172',
      'pdf file':'C172.pdf'
    },
    {
      'name aircraft':'Boeing 737-600',
      'pdf file':'B737.pdf'
    },
    {
      'name aircraft':'Boeing 737-700',
      'pdf file':'B737.pdf'
    },
    {
      'name aircraft':'Boeing 737-800',
      'pdf file':'B737.pdf'
    },
    {
      'name aircraft':'Boeing 737-900',
      'pdf file':'B737.pdf'
    },
    {
      'name aircraft':'Boeing 747-400',
      'pdf file':'B747.pdf'
    },
    {
      'name aircraft':'Boeing 777-600',
      'pdf file':'B777.pdf'
    },
  ];

  Future<List> filter_aircrafts(String query)async{
    List<Map<String, dynamic>> aircrafts=[];
    for(int i=0;i<List_aircrafts.length;i++){
      if(List_aircrafts[i]['name aircraft'].toLowerCase().contains(query.toLowerCase())){
        aircrafts.add(List_aircrafts[i]);
        }
    }
    return aircrafts;
  }
}