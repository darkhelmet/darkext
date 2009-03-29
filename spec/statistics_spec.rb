require File.dirname(__FILE__) + '/spec_helper'

describe Array do
  before(:each) do
    @a = [1,2,3,4,5,6,7,8,9,10]
  end

  it 'should respond to all the new methods' do
    Array.new.should respond_to(*%w(mean average ave harmonic_mean h_mean geometric_mean g_mean median histogram mode standard_deviation stddev standard_deviation sample ci standardize standardize! sum_of_squares))
    Darkext::Statistics.should respond_to(*%w(prob zscore p_val))
    Darkext::Statistics::Regression.should respond_to(*%w(least_squares))
  end

  it 'should return a Numeric from mean, harmonic_mean, geometric_mean, median, variance, standard_deviation, and sum_of_squares' do
    %w(mean harmonic_mean geometric_mean median variance standard_deviation sum_of_squares).each do |method|
      @a.send(method.intern).should be_a_kind_of(Numeric)
    end
  end

  it 'should return a hash from histogram' do
    @a.histogram.should be_a_kind_of(Hash)
  end

  it 'should return an array from mode, sample, ci, and standardize' do
    %w(mode sample ci standardize).each do |method|
      @a.send(method.intern).should be_a_kind_of(Array)
    end
  end

  it 'should raise and erro from mean, harmonic_mean, geometric_mean, median, mode, population_variance, sample_variance, standard_deviation, ci, and sum_of_squares if size is zero' do
    %w(mean harmonic_mean geometric_mean median mode population_variance sample_variance population_deviation sample_deviation geometric_deviation ci sum_of_squares).each do |method|
      lambda { Array.new.send(method.intern) }.should raise_error
    end
  end

  it 'should return a Numeric from prob and zscore' do
    Darkext::Statistics::prob(1).should be_a_kind_of(Numeric)
    Darkext::Statistics::zscore(0.9).should be_a_kind_of(Numeric)
  end

  it 'should return a Numeric from p_val' do
    Darkext::Statistics::p_val(@a).should be_a_kind_of(Numeric)
  end

  it 'should return a Hash from least_squares' do
    Darkext::Statistics::Regression::least_squares([1,2,4,5],[2,3,6,10]).should be_a_kind_of(Hash)
  end

  it 'should raise an error if the arguments to least_squares have different sizes' do
    lambda { Darkext::Statistics::Regression::least_squares(@a,[1,2,3]) }.should raise_error
  end

  it 'should raise an error if either argument has size.zero?' do
    lambda { Darkext::Statistics::Regression::least_squares(@a,Array.new) }.should raise_error
  end
end
