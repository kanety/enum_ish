describe EnumIsh::Definer do
  context 'inheritance' do
    let(:user) { UserModel.new }
    let(:general) { UserModel::General.new }
    let(:manager) { UserModel::Manager.new }

    it 'overwrites enum definitions' do
      expect(general.class._enum_ish_enums[:status].mapping).to eq(enable: "enable")
      expect(manager.class._enum_ish_enums[:status].mapping).to eq(disable: "disable")
      expect(user.class._enum_ish_enums[:status].mapping).to eq({ enable: "enable", disable: "disable" })
    end

    it 'overwrites options method' do
      expect(general.class.status_options).to eq([["有効", "enable"]])
      expect(manager.class.status_options).to eq([["無効", "disable"]])
    end
  end
end
