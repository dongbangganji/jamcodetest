<?php

namespace App\Domain;

interface FitnessCoachInterface
{
    public function recommendSolution($lifestyleTags);
}
