<?php

namespace Tests\Unit;

//use PHPUnit\Framework\TestCase;
use App\Domain\FitnessCoach;
use Tests\TestCase;

class fitnessCoachTest extends TestCase
{
    public function testFitnessCoach()
    {
        $result = true;
        $rules = config('fitness');
        $fitnessCoach = new FitnessCoach();
        foreach ($rules as $value) {
            $value = $fitnessCoach->recommendSolution((object)$value);
            if ($value === 'not_found') {
                $result = [false, "정책이 변경 확인 필요"];
            }
        }
        $this->assertTrue($result);
    }
}
