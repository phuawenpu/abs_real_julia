module Initialise_Agents

using DataFrames
include("./Model_Functions.jl")



function populate_agents(df, row_number, agent_list)
    # step through the decile of income in the population, 
    # generate each individual agent's household income based
    # on the range within the decile
    # Main.VSCodeServer.vscodedisplay(df)
    sim_samplesize = Int32(round(size(agent_list)[1]/10))
       
    index = 1

    for i in 1:sim_samplesize #generate the first decile
        min_income = df[row_number,:"min_income"]
        max_income = df[row_number,:"percentile15"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the second decile
        min_income = df[row_number,:"percentile15"]
        max_income = df[row_number,:"percentile25"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the third decile
        min_income = df[row_number,:"percentile25"]
        max_income = df[row_number,:"percentile35"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the fourth decile
        min_income = df[row_number,:"percentile35"]
        max_income = df[row_number,:"percentile45"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the fifth decile
        min_income = df[row_number,:"percentile55"]
        max_income = df[row_number,:"percentile65"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the sixth decile
        min_income = df[row_number,:"percentile65"]
        max_income = df[row_number,:"percentile75"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the seventh decile
        min_income = df[row_number,:"percentile75"]
        max_income = df[row_number,:"percentile85"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the eigth decile
        min_income = df[row_number,:"percentile85"]
        max_income = df[row_number,:"percentile95"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the ninth decile
        min_income = df[row_number,:"percentile95"]
        max_income = df[row_number,:"percentile100"] - 1
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end

    for i in 1:sim_samplesize #generate the tenth decile
        min_income = df[row_number,:"percentile100"]
        max_income = df[row_number,:"max_income"] 
        agent_list[index]= Int32(round(rand(min_income:max_income)))
        index += 1
    end



    return nothing
end


function savings_agents(agent_list; savings_lo, savings_hi)
    # given the household income, randomly choose a rate of savings within a range 
    # to give a corresponding vector of savings
    a_size = size(agent_list)[1]
    for i in 1:a_size
        agent_list[a_size + i]= Int32(round(rand(savings_lo:savings_hi)/100 * agent_list[a_size]))
        
    end
end

function expenditure_agents(agent_list)
    # given the household income and savings amount
    # work out the household expenditure
    a_size = size(agent_list)[1]
    for i in 1:a_size
        saving = agent_list[i] - agent_list[a_size + i]
        if saving < 0 
            agent_list[2* a_size + i] = 0
        else
            agent_list[2* a_size + i] = saving
        end
        
    end
end

function price_house_list(house_list)
    for i in 1:size(house_list)[1]
        house_list[i] = Model_Functions.house_price(agent_list[i],income_df[row_number,:"min_income"],60000, 0.0005)
    end
end

export populate_agents, savings_agents, expenditure_agents, price_house_list

end #end module