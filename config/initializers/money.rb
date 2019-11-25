Money.default_bank = Money::Bank::VariableExchange.new(ExchangeRate)

Money.default_bank.add_rate('THB', 'USD', 1 / 33.12)
Money.default_bank.add_rate('CAD', 'USD', 1 / 1.3297)
