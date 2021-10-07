require 'rspec'

describe 'starting background process' do
	# before :all do
    #     ENV['ES_PATH_CONF'] = File.join(Path.dirname(__FILE__), "../config/master-1")
    #     puts "aha?"
	# 	background_process('elasticsearch').with do |process|
	# 		process.ready_when_log_includes 'ready'
	# 	end
	# 	.start
	# 	.wait_ready
	# end

	example 'test with process running in background' do
        it 'does something' do 
            expect(1).to eq 1
        end
	end

    it 'does that' do
        expect(1).to eq 2
    end
end