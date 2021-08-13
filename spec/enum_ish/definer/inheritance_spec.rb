describe EnumIsh::Definer do
  context 'inheritance' do
    let(:enable_user_model) {
      test_model(UserModel) do
        enum_ish :status, ['enable'], default: 'enable'
      end
    }
    let(:disable_user_model) {
      test_model(UserModel) do
        enum_ish :status, ['disable'], default: 'disable'
      end
    }
    let(:user) { UserModel.new }

    it 'has enum definitions' do
      expect(enable_user_model._enum_ish_enums[:status].mapping).to eq(enable: "enable")
      expect(disable_user_model._enum_ish_enums[:status].mapping).to eq(disable: "disable")
      expect(user.class._enum_ish_enums[:status].mapping).to eq({ enable: "enable", disable: "disable" })
    end

    it 'has options method' do
      expect(enable_user_model.status_options).to eq([["有効", "enable"]])
      expect(disable_user_model.status_options).to eq([["無効", "disable"]])
    end
  end
end
