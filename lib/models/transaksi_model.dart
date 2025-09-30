class TransaksiModel {
  int? id, type, total;
  String? name, createAT, updateAT;

  TransaksiModel(
    {
      this.id,
      this.type,
      this.total,
      this.name,
      this.createAT,
      this.updateAT,
    }
  );

  factory TransaksiModel.fromJson(Map<String, dynamic> json){
  return TransaksiModel(
    id: json['id'],
    type: json['type'],
    total: json['total'],
    name: json['name'],
    createAT: json['createAT'],
    updateAT: json['updateAT'],
  );
  }
}