$LOAD_PATH << File.dirname(__FILE__)

require 'solution'
require 'rspec'

describe MedianOfTwo do
    context '.median2' do
        let(:arr1) { a.map(&:to_i) }
        let(:arr2) { b.map(&:to_i) }
        let(:result) { MedianOfTwo.median((arr1 + arr2).sort) }
        
        subject { MedianOfTwo.median2(arr1, arr2) }
        
        context 'when both arrays have the same median' do
            let(:a) { %w[1 2 3 4 5] }
            let(:b) { %w[1 1 3 6 6] }
            
            it { is_expected.to eq result }
        end
        
        context 'when both arrays have the same median' do
            let(:a) { %w[1 2 3 4 5] }
            let(:b) { %w[1 1 2 4 6 6] }
            
            it { is_expected.to eq result }
        end
        
        context 'with one array empty' do
            let(:a) { %w[] }
            let(:b) { %w[1 1 3 6 6] }
            
            it { is_expected.to eq result }
        end
        
        context 'adjacent arrays a > b' do
            let(:a) { %w[1 2 3 4 5] }
            let(:b) { %w[5 6 7 8 9] }
            
            it { is_expected.to eq result }
        end
        
        context 'adjacent arrays b > a' do
            let(:b) { %w[1 2 3 4 5] }
            let(:a) { %w[5 6 7 8 9] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / odd odd' do
            let(:a) { %w[2 3 4 5 6] }
            let(:b) { %w[1 2 3] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / even odd' do
            let(:a) { %w[2 3 4 5] }
            let(:b) { %w[1 2 3] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / odd even' do
            let(:a) { %w[2 3 4 5 6] }
            let(:b) { %w[1 2 3 4] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / even even' do
            let(:a) { %w[2 3 4 5 6 7] }
            let(:b) { %w[1 2 3 4] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / even even' do
            let(:a) { %w[2 3 4 5 6 7] }
            let(:b) { %w[1 2 3 4 5 6] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / even even' do
            let(:a) { %w[2 3 4 5 6 7] }
            let(:b) { %w[-3 -2 -1 8 9 10] }
            
            it { is_expected.to eq result }
        end
        
        # median B > median A
        
        context 'overlaping arrays / odd odd' do
            let(:a) { %w[2 3 4 5 6] }
            let(:b) { %w[1 6 7] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / even odd' do
            let(:a) { %w[2 3 4 5] }
            let(:b) { %w[1 5 6] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / odd even' do
            let(:a) { %w[2 3 4 5 6] }
            let(:b) { %w[1 5 5 6] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / even even' do
            let(:a) { %w[2 3 4 5 6 7] }
            let(:b) { %w[1 5 6 7] }
            
            it { is_expected.to eq result }
        end
        
        context 'overlaping arrays / even even' do
            let(:a) { %w[2 3 4 5 6 7] }
            let(:b) { %w[1 5 6 7 8 9] }
            
            it { is_expected.to eq result }
        end
        
        xcontext 'overlaping arrays / even even' do
            let(:a) { %w[2 3 4 5 6 7] }
            let(:b) { %w[-5 -4 -3 6 7 ] }
            
            it { is_expected.to eq result }
        end
        
        context 'leetcode sample' do
            let(:a) { %w[1 4 5] }
            let(:b) { %w[2 3 6 7] }
            
            it { is_expected.to eq result }
        end

        context 'leetcode sample' do
            let(:a) { %w[1 2 4] }
            let(:b) { %w[3 5 6 7 8 9] }
            
            it { is_expected.to eq result }
        end
            
        context 'leetcode sample' do
            let(:a) { %w[1 3] }
            let(:b) { %w[2 7] }
            
            it { is_expected.to eq result }
        end
        
        context 'another sample' do
            let(:a) { %w[1 2] }
            let(:b) { %w[-1 3] }
            
            it { is_expected.to eq result }
        end
    end
end