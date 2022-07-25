class Exchange {
  final String time;
  final String asset_id_base;
  final String asset_id_quote;
  final double rate;

  Exchange(this.time, this.asset_id_base, this.asset_id_quote, this.rate);

  Exchange.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        asset_id_base = json['asset_id_base'],
        asset_id_quote = json['asset_id_quote'],
        rate = json['rate'];

  Map<String, dynamic> toJson() => {
        'time': time,
        'asset_id_base': asset_id_base,
        'asset_id_quote': asset_id_quote,
        'rate': rate,
      };
}
