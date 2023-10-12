sealed class GenerateBillState {
  const GenerateBillState();
}

class GenerateBillInitial implements GenerateBillState {
  const GenerateBillInitial() : super();
}

class GeneratingBill implements GenerateBillState {
  const GeneratingBill() : super();
}

class GeneratedBill implements GenerateBillState {
  const GeneratedBill() : super();
}

class GenerateBillError implements GenerateBillState {
  const GenerateBillError() : super();
}
