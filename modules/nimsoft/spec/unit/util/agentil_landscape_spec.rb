#!/usr/bin/env ruby

require 'spec_helper'
require 'puppet/util/agentil'
require 'puppet/util/agentil_landscape'
require 'puppet/util/nimsoft_section'

describe Puppet::Util::AgentilLandscape do

  before :each do
    Puppet::Util::Agentil.initvars
  end

  let :landscape do
    described_class.new(13, landscape_element)
  end

  let :new_landscape do
    described_class.new(29, new_landscape_element)
  end

  let :landscape_element do
    {
      'COMPANY'            => 'Examplesoft',
      'SYSTEM_ID'          => 'PRO',
      'MONITORTREE_MAXAGE' => '480',
      'NAME'               => 'sap01.example.com',
      'DESCRIPTION'        => 'sap01.example.com',
      'ID'                 => '13',
      'ACTIVE'             => 'true',
      'CONNECTORS'         => [1, 3]
    }
  end

  let :new_landscape_element do
    {
      "ID"     => "29",
      "ACTIVE" => "true"
    }
  end

  describe "id" do
    it "should return the id as integer" do
      expect(landscape.id).to eq(13)
    end
  end

  {
    :company     => 'COMPANY',
    :sid         => 'SYSTEM_ID',
    :description => 'DESCRIPTION'
  }.each_pair do |property, attribute|
    describe "getting #{property}" do
      it "should return nil if attribute #{attribute} does not exist" do
        expect(new_landscape.send(property)).to be_nil
      end
      it "should return the value of attribute #{attribute}" do
        landscape.element.expects(:[]).with(attribute).returns 'foo'
        expect(landscape.send(property)).to eq('foo')
      end
    end

    describe "setting #{property}" do
      it "should modify attribute #{attribute}" do
        landscape.element.expects(:[]=).with(attribute, 'foo')
        landscape.send("#{property}=", 'foo')
      end
    end
  end

  describe "systems" do
    it "should return the correct system objects" do
      system1 = mock 'system1'
      system3 = mock 'system3'
      Puppet::Util::Agentil.systems.expects(:[]).with(1).returns system1
      Puppet::Util::Agentil.systems.expects(:[]).with(3).returns system3
      expect(landscape.systems).to eq([ system1, system3 ])
    end

    it "should raise an error if a system cannot be found" do
      Puppet::Util::Agentil.systems.expects(:[]).with(1).returns mock 'foo'
      Puppet::Util::Agentil.systems.expects(:[]).with(3).returns nil
      expect { landscape.systems }.to raise_error Puppet::Error, /System with id=3 could not be found/
    end
  end

  describe "assign_system" do
    it "should add new system to the internal array" do
      expect(landscape.assigned_systems).to eq([1, 3])
      landscape.assign_system 10
      expect(landscape.assigned_systems).to eq([1, 3, 10])
    end

    it "should not assign a system twice" do
      expect(landscape.assigned_systems).to eq([1, 3])
      landscape.assign_system 3
      expect(landscape.assigned_systems).to eq([1, 3])
    end

    it "should add the system to the appropiate systems section" do
      expect(landscape.element['CONNECTORS']).to eq([ 1,3 ])
      landscape.assign_system 10
      expect(landscape.element['CONNECTORS']).to eq([ 1,3,10 ])
    end

    it "should create the systems section first if necessary" do
      expect(new_landscape.element).to_not have_key('CONNECTORS')
      expect(new_landscape.assigned_systems).to be_empty

      new_landscape.assign_system 33

      expect(new_landscape.assigned_systems).to eq([ 33 ])
      expect(new_landscape.element['CONNECTORS']).to eq([33])
    end
  end

  describe "deassign_system" do
    it "should delete the system from the internal array" do
      expect(landscape.assigned_systems).to eq([1, 3])
      landscape.deassign_system 1
      expect(landscape.assigned_systems).to eq([3])
    end

    it "should do nothing if system is not assigned" do
      expect(landscape.assigned_systems).to eq([1, 3])
      landscape.deassign_system 10
      expect(landscape.assigned_systems).to eq([1, 3])
    end

    it "should delete the system from the appropiate systems section" do
      expect(landscape.element['CONNECTORS']).to eq([1, 3])
      landscape.deassign_system 1
      expect(landscape.element['CONNECTORS']).to eq([ 3 ])
    end

    it "should completly remove the systems section if last assignment was removed" do
      landscape.deassign_system 1
      landscape.deassign_system 3

      expect(landscape.assigned_systems).to be_empty
      expect(new_landscape.element).to_not have_key('CONNECTORS')
    end
  end
end
