RSpec.describe SnippetConverter do
  context 'version' do
    it 'has a version number' do
      expect(SnippetConverter::VERSION).not_to be nil
    end
  end

  context 'methods' do
    it 'responds to parse' do
      expect(SnippetConverter).to respond_to('parse')
    end
    it 'responds to convert_to_vsc' do
      expect(SnippetConverter).to respond_to('convert_to_vsc')
    end
    it 'responds to format_body' do
      expect(SnippetConverter).to respond_to('format_body')
    end
    it 'responds to write_file' do
      expect(SnippetConverter).to respond_to('write_file')
    end
    it 'responds to create_json_snippet' do
      expect(SnippetConverter).to respond_to('create_json_snippet')
    end
    it 'responds to read_snippet' do
      expect(SnippetConverter).to respond_to('read_snippet')
    end
  end
end
