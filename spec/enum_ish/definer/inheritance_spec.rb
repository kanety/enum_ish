describe EnumIsh::Definer do
  context 'inheritance' do
    let(:manager) { UserModel::Manager.new }
    let(:general) { UserModel::General.new }

    it 'overwrites enum definitions' do
      expect(manager.class._enum_ish_enums[:str].mapping).to eq(status1: "status1", status2: "status2")
      expect(general.class._enum_ish_enums[:str].mapping).to eq(status2: "status2", status3: "status3")
    end

    it 'overwrites options method' do
      expect(manager.class.str_options).to eq([["文字列１", "status1"], ["文字列２", "status2"]])
      expect(general.class.str_options).to eq([["文字列２", "status2"], ["文字列３", "status3"]])
    end
  end
end
