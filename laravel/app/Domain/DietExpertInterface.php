<?php

namespace App\Domain;

interface DietExpertInterface
{
    public function recommendSolution($lifestyleTags);
}
