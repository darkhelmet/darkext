require File.dirname(__FILE__) + '/spec_helper'

describe Array do
  before(:each) do
    @a = [1,2,3,4,5,6,7,8,9,10]
    @hist = [1,2,1,1,3,2,1,1,3,3,3,3,3,2,2,1]
    @b = [5,1,9,12,6,7,8,8,8,1,2,3,4]
  end

  it 'should respond to all the new methods' do
    Array.new.should respond_to(*%w(mean average ave harmonic_mean h_mean geometric_mean g_mean median histogram mode standard_deviation stddev standard_deviation sample ci standardize standardize! sum_of_squares))
    Darkext::Statistics.should respond_to(*%w(prob zscore))
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

  it 'should return a Hash from least_squares' do
    Darkext::Statistics::Regression::least_squares([1,2,4,5],[2,3,6,10]).should be_a_kind_of(Hash)
  end

  it 'should raise an error if the arguments to least_squares have different sizes' do
    lambda { Darkext::Statistics::Regression::least_squares(@a,[1,2,3]) }.should raise_error
  end

  it 'should raise an error if either argument has size.zero?' do
    lambda { Darkext::Statistics::Regression::least_squares(@a,Array.new) }.should raise_error
  end

  it 'should handle mean' do
    (1..6).to_a.mean.should == 3.5
    [1].mean.should == 1
  end

  it 'should handle harmonic mean' do
    [60,40].harmonic_mean.should be_close(48, 0.0001)
    [9].harmonic_mean.should be_close(9, 0.0001)
  end

  it 'should handle geometric mean' do
    [2,8].geometric_mean.should == 4
    [9].geometric_mean.should be_close(9, 0.0001)
  end

  it 'should handle median' do
    (1..3).to_a.median.should == 2
    [1].median.should == 1
    [2,4,6,8].median.should == 5
  end

  it 'should make histograms' do
    @hist.histogram.should == { 1 => 6, 2 => 4, 3 => 6 }
  end

  it 'should handle mode' do
    @hist.mode.should == [1,3]
    (@hist + [1]).mode.should == [1]
  end

  it 'should handle variance' do
    (1..6).to_a.variance.should be_close(35/12, 0.0001)
    [1].variance.should be_close(0, 0.0001)
    [1,1].variance.should be_close(0, 0.0001)
    @b.variance.should be_close(10.5, 0.05)
  end

  it 'should handle std dev' do
    [2,4,4,4,5,5,7,9].stddev.should be_close(2, 0.0001)
    @b.stddev.should be_close(3.24, 0.01)
  end

  it 'should sample' do
    @hist.sample(5).size.should == 5
  end

  it 'should handle confidence intervals' do
    ci = @b.ci
    ci.shift.should be_close(5.15, 0.01)
    ci.shift.should be_close(6.24, 0.01)
    @b.ci(:type => :upper).shift.should be_close(6.15, 0.01)
    @b.ci(:type => :lower).shift.should be_close(5.24, 0.01)
  end

  it 'should standardize' do
    [2,2,4,4].standardize.should == [-1,-1,1,1].map(&:to_f)
    @b.standardize.size.should == 13
  end

  it 'should do sum of squares' do
    (1..3).to_a.sum_of_squares.should == 2.0
  end

  it 'should do probability' do
    Darkext::Statistics::prob(2).should be_close(0.96, 0.02)
    Darkext::Statistics::prob(0.5).should be_close(0.69, 0.02)
    Darkext::Statistics::prob(Darkext::Statistics::zscore(1)).should be_close(1, 0.0001)
  end

  it 'should do zscore' do
    Darkext::Statistics::zscore(0.5).should be_close(0, 0.1)
    Darkext::Statistics::prob(0.75).should be_close(0.77, 0.02)
    Darkext::Statistics::zscore(Darkext::Statistics::prob(2.5)).should be_close(2.5, 0.0001)
  end

  it 'should handle regressions' do
    xs = [0,1.2,2,2.9,4,5,6]
    ys = [0.1,1,2.1,3,4.3,4.9,6]

    results = Darkext::Statistics::Regression::least_squares(xs,ys)

    results[:n].should == xs.size
    results[:b_1].should be_close(1, 0.1)
    results[:b_0].should be_close(0, 0.1)
    results[:predicted].size.should == xs.size

    results[:predicted].each_with_index do |pred,index|
      pred.should be_close(index, 0.3)
    end

    results[:residuals].size.should == xs.size

    results[:residuals].each_with_index do |pred,index|
      pred.should be_close(0, 0.3)
    end

    results[:ss_e].should be_close(0.15, 0.01)
    results[:ss_t].should be_close(27.49, 0.01)
    results[:estimator].should be_close(0.03, 0.01)
    results[:r_2].should be_close(1, 0.01)
    results[:r].should be_close(1, 0.01)

    eqn = results[:equation]
    (0..100).each do |i|
      eqn.call(i).should be_close(i, 0.25)
    end
  end
end
