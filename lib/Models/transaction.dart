class Transaction {
  final String trans_id;
  final String title;
  final String type;
  final int amount;
  final DateTime date;
  Transaction(
    this.trans_id,
    this.title,
    this.type,
    this.amount,
    this.date,
  );
}
