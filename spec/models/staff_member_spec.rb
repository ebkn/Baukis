require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe 'normalization' do
    context 'when email' do
      it 'deletes before and after trailing spaces' do
        email = Faker::Internet.email
        member = create(:staff_member, email: " #{email} ")
        expect(member.email).to eq email
      end

      it 'converts before and after fullwidth trailing spaces' do
        email = Faker::Internet.email
        member = create(:staff_member, email: "\u{3000}#{email}\u{3000}")
        expect(member.email).to eq email
      end

      it 'converts from fullwidth char to halfwidth char' do
        email = 'ｔｅｓｔ＠ｔｅｓｔ．ｃｏｍ'
        member = create(:staff_member, email: email)
        expect(member.email).to eq 'test@test.com'
      end
    end

    context 'when name' do
      it 'converts from family_name_kana including hiragana to katakana' do
        hiragana_name = 'てすと'
        member = create(:staff_member, family_name_kana: hiragana_name)
        expect(member.family_name_kana).to eq 'テスト'
      end

      it 'converts from halfwidth family_name_kana to fullwidth' do
        halfwidth_name = 'ﾃｽﾄ'
        member = create(:staff_member, family_name_kana: halfwidth_name)
        expect(member.family_name_kana).to eq 'テスト'
      end

      it 'converts from given_name_kana including hiragana to katakana' do
        hiragana_name = 'てすと'
        member = create(:staff_member, given_name_kana: hiragana_name)
        expect(member.given_name_kana).to eq 'テスト'
      end

      it 'converts from halfwidth given_name_kana to fullwidth' do
        halfwidth_name = 'ﾃｽﾄ'
        member = create(:staff_member, given_name_kana: halfwidth_name)
        expect(member.given_name_kana).to eq 'テスト'
      end
    end
  end

  describe 'validation' do
    context 'valid' do
      it 'is valid factory' do
        expect(build(:staff_member)).to be_valid
      end

      it 'is valid with family_name includes hiragana' do
        name = 'きむら'
        member = build(:staff_member, family_name: name, family_name_kana: 'キムラ')
        expect(member).to be_valid
      end

      it 'is valid with family_name includes katakana and "-"' do
        name = 'クルーズ'
        member = build(:staff_member, family_name: name, family_name_kana: name)
        expect(member).to be_valid
      end

      it 'is valid with family_name includes alphabet' do
        name = 'Potter'
        member = build(:staff_member, family_name: name, family_name_kana: 'ポッター')
        expect(member).to be_valid
      end

      it 'is valid with given_name includes hiragana' do
        name = 'れな'
        member = build(:staff_member, given_name: name, given_name_kana: 'レナ')
        expect(member).to be_valid
      end

      it 'is valid with given_name includes katakana and "-"' do
        name = 'ジョニー'
        member = build(:staff_member, given_name: name, given_name_kana: name)
        expect(member).to be_valid
      end

      it 'is valid with given_name includes alphabet' do
        name = 'Harry'
        member = build(:staff_member, given_name: name, given_name_kana: 'ハリー')
        expect(member).to be_valid
      end

      it 'is valid with family_name_kana includes "-"' do
        name = 'エリー'
        member = build(:staff_member, family_name_kana: name)
        expect(member).to be_valid
      end

      it 'is valid with given_name_kana includes "-"' do
        name = 'エリー'
        member = build(:staff_member, given_name_kana: name)
        expect(member).to be_valid
      end
    end

    context 'invalid' do
      it 'is invalid without email' do
        member = build(:staff_member, email: nil)
        expect(member).not_to be_valid
      end

      it 'is invalid with invalid email' do
        invalid_email = 'test@@test.com'
        member = build(:staff_member, email: invalid_email)
        expect(member).not_to be_valid
      end

      it 'is invalid with duplicated email' do
        email = Faker::Internet.email
        create(:staff_member, email: email)
        member = build(:staff_member, email: email)
        expect(member).not_to be_valid
      end

      it 'is invalid without family_name' do
        member = build(:staff_member, family_name: nil)
        expect(member).not_to be_valid
      end

      it 'is invalid with family_name includes greece word' do
        greece_word = 'λ'
        member = build(:staff_member, family_name: greece_word, family_name_kana: greece_word)
        expect(member).not_to be_valid
      end

      it 'is invalid without given_name' do
        member = build(:staff_member, given_name: nil)
        expect(member).not_to be_valid
      end

      it 'is invalid with given_name includes greece word' do
        greece_word = 'λ'
        member = build(:staff_member, given_name: greece_word, given_name_kana: greece_word)
        expect(member).not_to be_valid
      end

      it 'is invalid without family_name_kana' do
        member = build(:staff_member, family_name_kana: nil)
        expect(member).not_to be_valid
      end

      it 'is invalid with family_name_kana including kanji' do
        kanji_name_kana = '佐藤'
        member = build(:staff_member, family_name_kana: kanji_name_kana)
        expect(member).not_to be_valid
      end

      it 'is invalid without given_name_kana' do
        member = build(:staff_member, given_name_kana: nil)
        expect(member).not_to be_valid
      end

      it 'is invalid with given_name_kana including kanji' do
        kanji_name_kana = '隼也'
        member = build(:staff_member, given_name_kana: kanji_name_kana)
        expect(member).not_to be_valid
      end

      it 'is invalid without start_date' do
        member = build(:staff_member, start_date: nil)
        expect(member).not_to be_valid
      end

      it 'is invalid with start_date before 2017/1/1' do
        member = build(:staff_member, start_date: Date.new(2016, 12, 31))
        expect(member).not_to be_valid
      end

      it 'is invalid with end_date before start_date' do
        member = build(:staff_member, start_date: Time.zone.today, end_date: Time.zone.yesterday)
        expect(member).not_to be_valid
      end
    end
  end

  describe '#password=' do
    it 'creates 60 characters hashed_password' do
      member = StaffMember.new
      member.password = Faker::Superhero.name
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    it 'creates nil hashed_password' do
      member = StaffMember.new
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end
end
