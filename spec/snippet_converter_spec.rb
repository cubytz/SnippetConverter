RSpec.describe SnippetConverter do
  it 'has a version number' do
    expect(SnippetConverter::VERSION).not_to be nil
  end

  context 'methods' do
    it 'responds to parse' do
      expect(SnippetConverter).to respond_to('parse')
    end
    it 'responds to convert' do
      expect(SnippetConverter).to respond_to('convert')
    end
    it 'responds to format_body' do
      expect(SnippetConverter).to respond_to('format_body')
    end
    it 'responds to output_file' do
      expect(SnippetConverter).to respond_to('output_file')
    end
  end

end
