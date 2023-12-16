<?php

namespace App\Application\PersonalTrainer;

use App\Domain\DietExpert;
use App\Domain\FitnessCoach;

class PersonalTrainerService
{
    public DietExpert $dietExpert;
    public FitnessCoach $fitnessCoach;

    public function __construct(DietExpert $dietExpert, FitnessCoach $fitnessCoach)
    {
        $this->dietExpert = $dietExpert;
        $this->fitnessCoach = $fitnessCoach;
    }

    public function getSolution(object $data): string
    {
        return match ($data->solution_type) {
            'DIET' => $this->dietExpert->recommendSolution($data->lifestyle_tags),
            'FITNESS' => $this->fitnessCoach->recommendSolution($data->lifestyle_tags),
            default => "not found",
        };
    }
}
