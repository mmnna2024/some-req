require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空文字の場合' do
      it 'バリデーションに失敗する' do
        first_task.update(title: nil)
        expect(first_task).to be_invalid
        expect(first_task.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end
    
  end
end
